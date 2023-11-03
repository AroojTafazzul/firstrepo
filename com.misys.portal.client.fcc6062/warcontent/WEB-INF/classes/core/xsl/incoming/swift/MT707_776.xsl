<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:swifttools="xalan://com.neomalogic.gtp.interfaces.tools.SwiftTools"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		exclude-result-prefixes="swifttools service">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<776/707> Advice of Amendment of Documentary Credit into el_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
    <xsl:param name="reference"/>
    <xsl:param name="language">en</xsl:param>  
	<xsl:param name="product_code">EL</xsl:param>   
	
	<xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>    
   
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT707']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT707']">
    <xsl:variable name="payment_type">
			<xsl:choose>
				<xsl:when test="AvailWithByA"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByA"/></xsl:with-param></xsl:call-template></xsl:when>
				<xsl:when test="AvailWithByD"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param></xsl:call-template></xsl:when>
			</xsl:choose>
	 </xsl:variable>   
	<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
        <brch_code>00001</brch_code>
        <!-- AdvisingBankReferenceNumber -->
        <xsl:variable name="BORefId"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT707']/SenderRef"/></xsl:variable>
        <ref_id><xsl:value-of select="service:retrieveRefIdFromBoRefId($BORefId, $product_code)"/></ref_id>
        <lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/DocCreditNo"/></lc_ref_id> 
       	<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT707']/SenderRef"/></bo_ref_id>
		<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/BankReferenceNumber"/></bo_tnx_id>
		<tnx_type_code>03</tnx_type_code>
		<sub_tnx_type_code>
			<xsl:choose>
				<xsl:when test="IncreaseDocCrAmount">01</xsl:when>
				<xsl:when test="DecreaseDocCrAmount">02</xsl:when>
				<xsl:otherwise>03</xsl:otherwise>		
			</xsl:choose>	
		</sub_tnx_type_code>
		<prod_stat_code>08</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>  
		<product_code><xsl:value-of select="$product_code"/></product_code>	
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:apply-templates select="DatePlaceExpiry" mode="date"/>
		<xsl:apply-templates select="DateOfAmend"/>		
		<xsl:apply-templates select="NoOfAmend"/>	
		<xsl:apply-templates select="LatestShipDate"/>				
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT776']/CreationDateTime">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT776']/CreationDateTime"/>
		</xsl:if>				
		<!--<xsl:apply-templates select="IncreaseDocCrAmount"/>	
		<xsl:apply-templates select="DecreaseDocCrAmount"/>-->
		<xsl:call-template name="IncreaseDecreaseDocCrAmount"/>		
		<xsl:if test="NewDocCrAmtAfter">
			<!-- Credit amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(NewDocCrAmtAfter,4)"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
			</xsl:variable>		
			<lc_cur_code><xsl:value-of select="substring(NewDocCrAmtAfter,1,3)"/></lc_cur_code>			  	
	      	<lc_amt><xsl:value-of select="$amount"/></lc_amt>
      	</xsl:if>

		<xsl:apply-templates select="Beneficiary" mode="el">
			<xsl:with-param name="index_details" select="../MeridianMessage[ExternalMessageType = 'MT776']/AdvisingBankInformation"/>	
		</xsl:apply-templates>
		      	
		<xsl:apply-templates select="DatePlaceExpiry" mode="place"/>
		<xsl:apply-templates select="PartialShipments"/>
		<xsl:apply-templates select="Transhipment"/>     	
      	<xsl:apply-templates select="LoadDispatchTakeCharge"/>
      	<xsl:apply-templates select="PortofLoading"/>
      	<xsl:apply-templates select="PortofDischarge"/>
      	<xsl:apply-templates select="ForTransportTo"/>
      	<xsl:apply-templates select="LatestShipDate"/>
      	<xsl:apply-templates select="ConfirmationIns"/>
      	<xsl:apply-templates select="PercentageCreditAmountTolerance"/>
      	<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template> 
		<xsl:apply-templates select="MaxCrAmount"/>
		<xsl:apply-templates select="IssuingBankA"/>
		<xsl:apply-templates select="IssuingBankD"/>
		<xsl:apply-templates select="AdvisingBankA"/>
		<xsl:apply-templates select="AdvisingBankD"/>
		<!-- ADVISE THRU BANK (only in LC product) 	-->
		<xsl:apply-templates select="AdviseThruBankA"/>
		<xsl:apply-templates select="AdviseThruBankB"/>	
		<xsl:apply-templates select="AdviseThruBankD"/>
		<!-- CREDIT AVAILABLE WITH BANK -->	
		<xsl:apply-templates select="AvailableWithByA"/>	
		<xsl:apply-templates select="AvailableWithByD"/>
		<!-- DRAWEE DETAILS BANK -->		
		<xsl:apply-templates select="DraweeA"/>	
		<xsl:apply-templates select="DraweeD"/>
		
		<xsl:if test="ApplicableRules!=''">
			<xsl:call-template name="ApplicableRulesLC">
				<xsl:with-param name="rule"><xsl:value-of select="ApplicableRules"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if> 
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AmendChrgPayable"/>	 
		<xsl:apply-templates select="PeriodForPresentation"/>     	 
		<xsl:apply-templates select="AddAmountsCovered"/>
		<xsl:apply-templates select="ShipPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>
		<!-- NARRATIVES -->
		<narrative_description_goods>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT707']/DescOfGoodsAndServices">
				<xsl:apply-templates select="DescOfGoodsAndServices"/>
			</xsl:if>	
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DescOfGoodsAndServices[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_description_goods>
		<narrative_documents_required>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT707']/DocumentsRequired">
						<xsl:apply-templates select="DocumentsRequired"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/DocumentsRequired[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_documents_required>
		<narrative_additional_instructions>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT707']/AdditionalConditions">
					<xsl:apply-templates select="AdditionalConditions"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/AdditionalConditions[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		 </narrative_additional_instructions>
		<xsl:if test="$swift2018Enabled">
			<xsl:apply-templates select="ReqConfirmPartyA"/>
			<xsl:apply-templates select="ReqConfirmPartyD"/>
			<narrative_special_beneficiary>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT707']/SpecialPaymentBeneficiary">
					<xsl:apply-templates select="SpecialPaymentBeneficiary"/>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary">
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentBeneficiary[../SequenceOfTotal = '8/8']"/>
				</xsl:if>
			</narrative_special_beneficiary>
			<narrative_special_recvbank>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT707']/SpecialPaymentReceivingBank">
					<xsl:apply-templates select="SpecialPaymentReceivingBank"/>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank">
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
						<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT708']/SpecialPaymentReceivingBank[../SequenceOfTotal = '8/8']"/>
				</xsl:if>
			</narrative_special_recvbank>
		</xsl:if>
		<xsl:apply-templates select="InsToPayAcceptNeg"/>
		<bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT776']/ConfirmationInformation and ../MeridianMessage[ExternalMessageType = 'MT776']/ConfirmationInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/ConfirmationInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT776']/ChargesInformation and ../MeridianMessage[ExternalMessageType = 'MT776']/ChargesInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/ChargesInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>		
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT776']/ChargesInformation and ../MeridianMessage[ExternalMessageType = 'MT776']/ChargesInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/ChargesInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>			
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT776']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT776']/BankToCorporateInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT776']/AdvisingBankInformation and ../MeridianMessage[ExternalMessageType = 'MT776']/AdvisingBankInformation != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT776']/AdvisingBankInformation"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
		</xsl:if>
		</bo_comment>
		<amd_details>
			<xsl:apply-templates select="Narrative"/>
		</amd_details>							   	
      </el_tnx_record>
    </xsl:template>
    
	<xsl:template match="Narrative">		
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
	</xsl:call-template><xsl:text>
	</xsl:text>	
	</xsl:template>	
	    
</xsl:stylesheet>