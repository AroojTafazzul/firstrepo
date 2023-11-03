<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"	
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"	
		exclude-result-prefixes="localization service">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform Notification of Issuance of Documentary Credit
	MT798<771/700/701> into lc_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
  	<xsl:param name="reference"/> 
   	<xsl:param name="language">en</xsl:param>  
	<xsl:param name="product_code">LC</xsl:param> 
  
  	 <xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>
  	
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT700']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT700']">	
    <!--  get the payment for future use -->
		<xsl:variable name="payment_type">
			<xsl:choose>
				<xsl:when test="AvailWithByA"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByA"/></xsl:with-param></xsl:call-template></xsl:when>
				<xsl:when test="AvailWithByD"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param></xsl:call-template></xsl:when>
			</xsl:choose>
		</xsl:variable>	
       <lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
        <brch_code>00001</brch_code>
        <!-- TODO: we may get it from the index details CustomerReferenceNumber -->
        <xsl:variable name="refid"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT771']/CustomerReferenceNumber"/></xsl:variable>
        <ref_id><xsl:value-of select="$refid"/></ref_id>
        <!-- Retrieve the tnx_id from the ref_id so that the right transaction is updated -->
        <xsl:variable name="tnxid"><xsl:value-of select="service:retrieveTnxIdFromRefId($refid, $product_code, '01')"/></xsl:variable>
       	<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
	    <!-- Retrieve the tnx_id from the ref_id so that the right transaction is updated -->
	    <tnx_id><xsl:value-of select="$tnxid"/></tnx_id>        
		<!-- <adv_send_mode>01</adv_send_mode> -->
		<tnx_type_code>01</tnx_type_code>
		<!-- <sub_tnx_type_code/>	-->	
		<prod_stat_code>03</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:apply-templates select="DatePlaceExpiry" mode="date"/>
		<!-- <amd_date/>
		<amd_no/> -->
		<xsl:apply-templates select="LatestShipDate"/>
		<xsl:if test="CurrencyAmount">
			<tnx_cur_code><xsl:value-of select="substring(CurrencyAmount,1,3)"/></tnx_cur_code>
			<!-- Credit amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(CurrencyAmount,4)"/></xsl:with-param>
				</xsl:call-template>		
			</xsl:variable>
			<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			<lc_cur_code><xsl:value-of select="substring(CurrencyAmount,1,3)"/></lc_cur_code>
			<lc_amt><xsl:value-of select="$amount"/></lc_amt>
			<xsl:variable name="positive_tolerance"><xsl:value-of select="substring-before(PercentageCrAmountTolerance,'/')"/></xsl:variable>		
			<xsl:variable name="liab_amt"><xsl:value-of select="number(translate($amount,',','')) + number(translate($amount,',','')) * number($positive_tolerance div 100)"/></xsl:variable>
			<xsl:variable name="liab_amt_with_tolerance">
				<xsl:choose>
					<xsl:when test="string(number($positive_tolerance))='NaN'"><xsl:value-of select="$amount"/>
					</xsl:when>
					<xsl:otherwise><xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$liab_amt"/></xsl:with-param></xsl:call-template></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<lc_liab_amt><xsl:value-of select="$liab_amt_with_tolerance"/></lc_liab_amt>
			<lc_outstanding_amt><xsl:value-of select="$liab_amt_with_tolerance"/></lc_outstanding_amt>
		</xsl:if>	
		<lc_type>01</lc_type>
		<xsl:apply-templates select="Beneficiary"/>
		<xsl:apply-templates select="Applicant"/>
		<applicant_reference><xsl:value-of select="service:retrieveCustomerBankReference($refid, $tnxid, $product_code)"/></applicant_reference>
		<xsl:apply-templates select="DatePlaceExpiry" mode="place"/>		
		<!-- <inco_term/> -->
		<!-- <inco_place/> -->
		<xsl:apply-templates select="PartialShipments"/>
		<xsl:apply-templates select="Transhipment"/>
		<xsl:apply-templates select="LoadDispatchTakeCharge"/>
		<xsl:apply-templates select="PortofLoading"/>
		<xsl:apply-templates select="PortofDischarge"/>
		<xsl:apply-templates select="ForTransportTo"/>
		<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<!-- <cty_of_dest/>
		<rvlv_lc_type_code/>
		<max_no_of_rvlv/> -->
		<xsl:apply-templates select="PercentageCrAmountTolerance"/>
		
		<xsl:if test="not($swift2018Enabled)">
		<xsl:apply-templates select="MaxCrAmount"/>
		</xsl:if>
		
		<xsl:call-template name="cr_avl_by_code"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<!-- <dir_reim_flag/> -->
		<xsl:apply-templates select="FormOfDocCredit"/>
		<xsl:apply-templates select="ConfirmationInstructions"/>	
		<!-- ADVISE THRU BANK (only in LC product) 	-->
		<xsl:apply-templates select="AdviseThruBankA"/>
		<xsl:apply-templates select="AdviseThruBankB"/>	
		<xsl:apply-templates select="AdviseThruBankD"/>
			
		<!-- CREDIT AVAILABLE WITH BANK -->		
		<xsl:apply-templates select="AvailWithByA"/>	
		<xsl:apply-templates select="AvailWithByD"/>
		<!-- DRAWEE DETAILS BANK -->		
		<xsl:apply-templates select="DraweeA"/>	
		<xsl:apply-templates select="DraweeD"/>														
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/IssuingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/IssuingBankD"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/AdvisingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/AdvisingBankD"/>
		<xsl:call-template name="ApplicableRulesLC">
			<xsl:with-param name="rule"><xsl:value-of select="ApplicableRules"/></xsl:with-param>
		</xsl:call-template>
		<!-- NARRATIVES -->	
		<narrative_description_goods>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT700']/DescOfGoodsAndServices">
				<xsl:apply-templates select="DescOfGoodsAndServices"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_description_goods>
		<narrative_documents_required>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT700']/DocumentsRequired">
				<xsl:apply-templates select="DocumentsRequired"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_documents_required>
		<narrative_additional_instructions>	
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT700']/AdditionalConditions">
				<xsl:apply-templates select="AdditionalConditions"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_additional_instructions>
		<xsl:if test="$swift2018Enabled">
			<xsl:apply-templates select="ReqConfirmPartyA"/>
			<xsl:apply-templates select="ReqConfirmPartyD"/>
			<narrative_special_beneficiary>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT700']/SpecialPaymentBeneficiary">
					<xsl:apply-templates select="SpecialPaymentBeneficiary"/>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary">
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '8/8']"/>
				</xsl:if>
			</narrative_special_beneficiary>
			<narrative_special_recvbank>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT700']/SpecialPaymentReceivingBank">
					<xsl:apply-templates select="SpecialPaymentReceivingBank"/>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank">
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '8/8']"/>
				</xsl:if>
			</narrative_special_recvbank>
		</xsl:if>
		<xsl:if test="AddtlCustomerReference">
			<cust_ref_id><xsl:value-of select="AddtlCustomerReference"/></cust_ref_id>
		</xsl:if>
		<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT771']/BankRefNumber"/></bo_tnx_id>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT771']/CreationDateTime">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/CreationDateTime"/>
		</xsl:if>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/TextPurpose"/>
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AddAmtsCovered"/>
		<xsl:apply-templates select="InsToPayAcceptNeg"/>
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>		
		
		<bo_comment>	
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT771']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT771']/BankToCorporateInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT771']/BankToCorporateInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		</bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT771']/FileIdentification!=''">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT771']/FileIdentification"/>
		</xsl:if>
		</lc_tnx_record>
    </xsl:template>  
</xsl:stylesheet>
