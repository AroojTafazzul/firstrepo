<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<782/720/721> into el_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
    <xsl:param name="reference"/>  
    <xsl:param name="language">en</xsl:param>
	<xsl:param name="product_code">EL</xsl:param>    
  
  <xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT720']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT720']">
	    <!--  get the payment for future use -->
		<xsl:variable name="payment_type">
			<xsl:choose>
				<xsl:when test="AvailableWithByA"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailableWithByA"/></xsl:with-param></xsl:call-template></xsl:when>
				<xsl:when test="AvailableWithByD"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailableWithByD"/></xsl:with-param></xsl:call-template></xsl:when>
			</xsl:choose>
		</xsl:variable>
       <el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
        <brch_code>00001</brch_code>
        <lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT720']/TransferringBanksReference"/></lc_ref_id>
        <bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT782']/TransferringBankRefNumber"/></bo_ref_id>
        
        <bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT782']/BankReferenceNumber"/></bo_tnx_id>     
		<!-- <adv_send_mode>01</adv_send_mode>-->
		<tnx_type_code>01</tnx_type_code>
		<!-- <sub_tnx_type_code/> -->		
		<prod_stat_code>03</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT782']/CreationDateTime">
		<bo_release_dttm>	
			<xsl:call-template name="format_msg_creation_date">
				<xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT782']/CreationDateTime"/>
			</xsl:call-template>
		</bo_release_dttm>
		</xsl:if>
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="date"/>
		<xsl:call-template name="ApplicableRulesLC">
			<xsl:with-param name="rule"><xsl:value-of select="ApplicableRules"/></xsl:with-param>
		</xsl:call-template>
		
		<xsl:apply-templates select="IssuingBankOriginalA"/>
		<xsl:apply-templates select="IssuingBankOriginalD"/>
		
		<xsl:apply-templates select="LatestDateOfShipment"/>
		<xsl:apply-templates select="LatestShipDate"/>
		<xsl:if test="CcyCodeAmount">
			<tnx_cur_code><xsl:value-of select="substring(CcyCodeAmount,1,3)"/></tnx_cur_code>
			<!-- Credit amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(CcyCodeAmount,4)"/></xsl:with-param>
				</xsl:call-template>		
			</xsl:variable>
			<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			<lc_cur_code><xsl:value-of select="substring(CcyCodeAmount,1,3)"/></lc_cur_code>
			<lc_amt><xsl:value-of select="$amount"/></lc_amt>
			<xsl:variable name="positive_tolerance"><xsl:value-of select="substring-before(PercentageCreditAmountTolerance,'/')"/></xsl:variable>		
			<xsl:variable name="liab_amt"><xsl:value-of select="number(translate($amount,',','')) + number(translate($amount,',','')) * number($positive_tolerance div 100)"/></xsl:variable>
			<lc_liab_amt>
				<xsl:choose>
					<xsl:when test="string(number($positive_tolerance))='NaN'"><xsl:value-of select="$amount"/>
					</xsl:when>
					<xsl:otherwise><xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="$liab_amt"/></xsl:with-param></xsl:call-template></xsl:otherwise>
				</xsl:choose>
			</lc_liab_amt>	
		</xsl:if>	
		<lc_type>01</lc_type>
		<!-- Second beneficiary in an EL transfer -->
		<xsl:apply-templates select="SecondBeneficiary"/>
		<beneficiary_reference>
					<xsl:call-template name="extract_customer_reference">
						<xsl:with-param name="input">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankInformation"/>
						</xsl:with-param>
					</xsl:call-template>
		</beneficiary_reference>					
		<!-- Wrong spelling in Meridian -->
		<!-- First beneficiary in an EL transfer -->
		<xsl:apply-templates select="FirstBeneficiary"/>
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="place"/>		
		<inco_term/>
		<inco_place/>
		<xsl:apply-templates select="PartialShipments"/>
		
		<xsl:apply-templates select="Transhipment"/>
		
		<xsl:apply-templates select="PlaceTakingCharge"/>
		<xsl:apply-templates select="LoadDispatchTakeCharge"/>
		
		<xsl:apply-templates select="PortOfDeparture"/>
		<ship_discharge><xsl:value-of select="PortOfDischarge"/></ship_discharge>
		<ship_to><xsl:value-of select="FinalDestination"/></ship_to>
		<xsl:apply-templates select="PlcFinalDestinationTranspPlcDelivery"/>
		<xsl:apply-templates select="ForTransportTo"/>
		
		<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>											
		<!-- <cty_of_dest/>
		<rvlv_lc_type_code/>
		<max_no_of_rvlv/>-->
		<xsl:apply-templates select="PercentageCreditAmountTolerance"/>	
		<xsl:if test="not($swift2018Enabled)">	
		<xsl:apply-templates select="MaximumCreditAmount"/>	
		</xsl:if>
		<xsl:call-template name="cr_avl_by_code"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<!-- <dir_reim_flag/> -->
		<xsl:apply-templates select="FormOfDocumentaryCredit"/>
		<xsl:apply-templates select="ConfirmationInstructions"/>
		<cfm_flag><xsl:value-of select="ConfirmationIndicator"/></cfm_flag>		
		<!-- ISSUING BANK -->
		<xsl:apply-templates select="IssuingBankA"/>
		<xsl:apply-templates select="IssuingBankD"/>
		<!-- ADVISE THRU BANK -->
		<!-- Not exist in MTP ?		
		<xsl:apply-templates select="AdviseThroughBankA"/>
		<xsl:apply-templates select="AdviseThroughBankB"/>	
		<xsl:apply-templates select="AdviseThroughBankD"/>
		-->
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankD"/>
		
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT782']/TransferringBankA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT782']/TransferringBankB"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT782']/TransferringBankD"/>
		<!-- CREDIT AVAILABLE WITH BANK -->		
		<xsl:apply-templates select="AvailableWithByA"/>	
		<xsl:apply-templates select="AvailableWithByD"/>
		
		<xsl:apply-templates select="RequestedConfirmationPartyA"/>	
		<xsl:apply-templates select="RequestedConfirmationPartyD"/>
		<!-- DRAWEE DETAILS BANK -->		
		<xsl:apply-templates select="DraweeA"/>	
		<xsl:apply-templates select="DraweeD"/>														
		<!-- NARRATIVES -->	
		<narrative_description_goods>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT720']/DescriptionOfGoodsAndServices">
				<xsl:apply-templates select="DescriptionOfGoodsAndServices"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6'or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7'or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescriptionOfGoodsAndServices[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_description_goods>
		<narrative_documents_required>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT720']/DocumentsRequired">
				<xsl:apply-templates select="DocumentsRequired"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_documents_required>
		<narrative_additional_instructions>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT720']/AdditionalConditions">
				<xsl:apply-templates select="AdditionalConditions"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
		</narrative_additional_instructions>
		<xsl:if test="$swift2018Enabled">
			<narrative_special_beneficiary>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT720']/SpecialPaymentBeneficiary">
				<xsl:apply-templates select="SpecialPaymentBeneficiary"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpecialPaymentBeneficiary[../SequenceOfTotal = '8/8']"/>
			</xsl:if>
			</narrative_special_beneficiary>
			<narrative_special_recvbank>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT720']/SpecialPaymentReceivingBank">
					<xsl:apply-templates select="SpecialPaymentReceivingBank"/>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank">
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/SpclPymtCondForRcvngBank[../SequenceOfTotal = '8/8']"/>
				</xsl:if>
			</narrative_special_recvbank>
		</xsl:if>
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AdditionalAmountsCovered"/>
		<xsl:apply-templates select="InstrToPayingAccptNegBank"/>
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipmentPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>
		
		<bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT782']/ChargesInformation">
		-<!--<xsl:value-of select="localization:getGTPString($language, 'XSL_MT798_CHARGES_INFO')"/>--><xsl:text>
		</xsl:text>			
		<xsl:call-template name="string_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT782']/ChargesInformation"/>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:text>
		</xsl:text>
		</xsl:if>	
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT782']/ConfirmationInformation">
		-<!--<xsl:value-of select="localization:getGTPString($language, 'XSL_MT798_CONFIRMATION_INFO')"/--><xsl:text>
		</xsl:text>			
		<xsl:call-template name="string_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT782']/ConfirmationInformation"/>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:text>
		</xsl:text>
		</xsl:if>
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankInformation and ../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankInformation != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankInformation, '\n')"/>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:text>
		</xsl:text>
		</xsl:if>									
		</bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT782']/FileIdentification!=''">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT782']/FileIdentification"/>
		</xsl:if>					
	</el_tnx_record>
    </xsl:template>     
</xsl:stylesheet>
