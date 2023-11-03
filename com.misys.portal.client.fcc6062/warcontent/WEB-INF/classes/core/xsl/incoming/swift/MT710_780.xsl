<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"	
		exclude-result-prefixes="localization">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<780/710/MT711> Advice of Third Bank Documentary Credit into el_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
    <xsl:param name="reference"/>  
    <xsl:param name="language">en</xsl:param>
	<xsl:param name="product_code">EL</xsl:param>   
  
	 <xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT710']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT710']">
    <!--  get the payment for future use -->
		<xsl:variable name="payment_type">
			<xsl:choose>
				<xsl:when test="AvailableWithByA"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailableWithByA"/></xsl:with-param></xsl:call-template></xsl:when>
				<xsl:when test="AvailableWithByD"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailableWithByD"/></xsl:with-param></xsl:call-template></xsl:when>
			</xsl:choose>
		</xsl:variable>
       <el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
        <brch_code>00001</brch_code>
        <lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT710']/DocumentaryCreditNumber"/></lc_ref_id>
        <!-- AdvisingBankReferenceNumber in index message -->
        <bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/BankReferenceNumber"/></bo_ref_id>
		<!-- <adv_send_mode>01</adv_send_mode>-->
		<tnx_type_code>01</tnx_type_code>
		<!-- <sub_tnx_type_code/> -->		
		<prod_stat_code>03</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT780']/DateOfIssue"/>
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="date"/>
		<amd_date/>
		<amd_no/>
		<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT710']/SenderReference"/></bo_tnx_id>
		<xsl:apply-templates select="LatestDateOfShipment"/>
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
		<!-- Wrong spelling in Merdian -->
		<xsl:apply-templates select="Benificiary" mode="el">
			<xsl:with-param name="index_details" select="../MeridianMessage[ExternalMessageType = 'MT780']/AdvisingBankInformation"/>
		</xsl:apply-templates>		
		<xsl:apply-templates select="Applicant"/>	
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="place"/>	
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT780']/CreationDateTime">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT780']/CreationDateTime"/>
		</xsl:if>	
		<!-- <inco_term/>
		<inco_place/>-->
		<xsl:apply-templates select="PartialShipments"/>
		<xsl:apply-templates select="Transshipment"/>
		<xsl:apply-templates select="PlcTakChrgDispatchPlcRec"/>
		<xsl:apply-templates select="PortLoadingAirportDeparture"/>
		<xsl:apply-templates select="PortDischargeAirportDestination"/>
		<xsl:apply-templates select="PlcFinalDestinationTranspPlcDelivery"/>
		<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<!-- <cty_of_dest/>
		<rvlv_lc_type_code/>
		<max_no_of_rvlv/> -->
		<xsl:apply-templates select="PercentageCreditAmountTolerance"/>	
		<xsl:if test="not($swift2018Enabled)">	
		<xsl:apply-templates select="MaximumCreditAmount"/>
		</xsl:if>		
		<xsl:call-template name="cr_avl_by_code"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<!-- <dir_reim_flag/> -->
		<xsl:apply-templates select="FormOfDocumentaryCredit"/>
		<xsl:apply-templates select="ConfirmationInstructions"/>
		<xsl:call-template name="get_cfm_flag">
			<xsl:with-param name="input"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/ConfirmationIndicator"/></xsl:with-param>
		</xsl:call-template>		
		<!-- ISSUING BANK -->
		<xsl:apply-templates select="IssuingBankA"/>
		<xsl:apply-templates select="IssuingBankD"/>
		<!-- ADVISING BANK -->
		<xsl:apply-templates select="AdvisingBankA"/>
		<xsl:apply-templates select="AdvisingBankD"/>
		<!-- REQUESTED CONFIRMATION PARTY -->
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT710']/ReqConfirmationPartyA"/>
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT710']/ReqConfirmationPartyD"/>
		<xsl:call-template name="ApplicableRulesLC">
			<xsl:with-param name="rule"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT710']/ApplicableRules"/></xsl:with-param>
		</xsl:call-template>
		<xsl:if test = "../MeridianMessage[ExternalMessageType = 'MT780']/FirstAdvisingBankA">
		<xsl:call-template name="FirstAdvisingBankA">
			<xsl:with-param name="bank"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/FirstAdvisingBankA"/></xsl:with-param>
			<xsl:with-param name="reference"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/FirstAdvisingBankRefNumber"/></xsl:with-param>
		</xsl:call-template>
		</xsl:if>	
		<xsl:if test = "../MeridianMessage[ExternalMessageType = 'MT780']/FirstAdvisingBankD">	
		<xsl:call-template name="FirstAdvisingBankD">
			<xsl:with-param name="bank"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/FirstAdvisingBankD"/></xsl:with-param>
			<xsl:with-param name="reference"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/FirstAdvisingBankRefNumber"/></xsl:with-param>
		</xsl:call-template>
		</xsl:if>
	
		<!-- ADVISE THRU BANK -->
		<!-- Not exist in MTP ?		
		<xsl:apply-templates select="AdviseThroughBankA"/>
		<xsl:apply-templates select="AdviseThroughBankB"/>	
		<xsl:apply-templates select="AdviseThroughBankD"/>
		-->	
		<!-- CREDIT AVAILABLE WITH BANK -->		
		<xsl:apply-templates select="AvailableWithByA"/>	
		<xsl:apply-templates select="AvailableWithByD"/>
		<!-- DRAWEE DETAILS BANK -->		
		<xsl:apply-templates select="DraweeA"/>	
		<xsl:apply-templates select="DraweeD"/>														
		<!-- NARRATIVES -->	
		<narrative_description_goods>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT710']/DescriptionOfGoodsAndServices">
				<xsl:apply-templates select="DescriptionOfGoodsAndServices"/>	
			</xsl:if> 
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT711']/Description">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '1/1' or ../SequenceTotal = '1/2' or ../SequenceTotal = '1/3' or ../SequenceTotal = '1/4' or ../SequenceTotal = '1/5' or ../SequenceTotal = '1/6' or ../SequenceTotal = '1/7' or ../SequenceTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4' or ../SequenceTotal = '2/5' or ../SequenceTotal = '2/6' or ../SequenceTotal = '2/7' or ../SequenceTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4' or ../SequenceTotal = '3/5' or ../SequenceTotal = '3/6' or ../SequenceTotal = '3/7' or ../SequenceTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '4/4' or ../SequenceTotal = '4/5' or ../SequenceTotal = '4/6'or ../SequenceTotal = '4/7' or ../SequenceTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '5/5' or ../SequenceTotal = '5/6' or ../SequenceTotal = '5/7'or ../SequenceTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '6/6' or ../SequenceTotal = '6/7' or ../SequenceTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '7/7' or ../SequenceTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '8/8']"/>
			</xsl:if>
		</narrative_description_goods>
		<narrative_documents_required>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT710']/DocumentsRequired">
				<xsl:apply-templates select="DocumentsRequired"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '1/1' or ../SequenceTotal = '1/2' or ../SequenceTotal = '1/3' or ../SequenceTotal = '1/4' or ../SequenceTotal = '1/5' or ../SequenceTotal = '1/6' or ../SequenceTotal = '1/7' or ../SequenceTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4' or ../SequenceTotal = '2/5' or ../SequenceTotal = '2/6' or ../SequenceTotal = '2/7' or ../SequenceTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4' or ../SequenceTotal = '3/5' or ../SequenceTotal = '3/6' or ../SequenceTotal = '3/7' or ../SequenceTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '4/4' or ../SequenceTotal = '4/5' or ../SequenceTotal = '4/6' or ../SequenceTotal = '4/7' or ../SequenceTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '5/5' or ../SequenceTotal = '5/6' or ../SequenceTotal = '5/7' or ../SequenceTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '6/6' or ../SequenceTotal = '6/7' or ../SequenceTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '7/7' or ../SequenceTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '8/8']"/>
			</xsl:if>
		</narrative_documents_required>
		<narrative_additional_instructions>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT710']/AdditionalConditions">
				<xsl:apply-templates select="AdditionalConditions"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '1/1' or ../SequenceTotal = '1/2' or ../SequenceTotal = '1/3' or ../SequenceTotal = '1/4' or ../SequenceTotal = '1/5' or ../SequenceTotal = '1/6' or ../SequenceTotal = '1/7' or ../SequenceTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4' or ../SequenceTotal = '2/5' or ../SequenceTotal = '2/6' or ../SequenceTotal = '2/7' or ../SequenceTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4' or ../SequenceTotal = '3/5' or ../SequenceTotal = '3/6' or ../SequenceTotal = '3/7' or ../SequenceTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '4/4' or ../SequenceTotal = '4/5' or ../SequenceTotal = '4/6' or ../SequenceTotal = '4/7' or ../SequenceTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '5/5' or ../SequenceTotal = '5/6' or ../SequenceTotal = '5/7' or ../SequenceTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '6/6' or ../SequenceTotal = '6/7' or ../SequenceTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '7/7' or ../SequenceTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '8/8']"/>
			</xsl:if>
		</narrative_additional_instructions>
		<xsl:if test="$swift2018Enabled">
			<narrative_special_beneficiary>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT710']/SpclPymtCondForBeneficiary">
				<xsl:apply-templates select="SpclPymtCondForBeneficiary"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '1/1' or ../SequenceTotal = '1/2' or ../SequenceTotal = '1/3' or ../SequenceTotal = '1/4' or ../SequenceTotal = '1/5' or ../SequenceTotal = '1/6' or ../SequenceTotal = '1/7' or ../SequenceTotal = '1/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4' or ../SequenceTotal = '2/5' or ../SequenceTotal = '2/6' or ../SequenceTotal = '2/7' or ../SequenceTotal = '2/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4' or ../SequenceTotal = '3/5' or ../SequenceTotal = '3/6' or ../SequenceTotal = '3/7' or ../SequenceTotal = '3/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '4/4' or ../SequenceTotal = '4/5' or ../SequenceTotal = '4/6' or ../SequenceTotal = '4/7' or ../SequenceTotal = '4/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '5/5' or ../SequenceTotal = '5/6' or ../SequenceTotal = '5/7' or ../SequenceTotal = '5/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '6/6' or ../SequenceTotal = '6/7' or ../SequenceTotal = '6/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '7/7' or ../SequenceTotal = '7/8']"/>
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForBeneficiary[../SequenceTotal = '8/8']"/>
			</xsl:if>
			</narrative_special_beneficiary>
			<narrative_special_recvbank>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT710']/SpclPymtCondForRcvngBank">
					<xsl:apply-templates select="SpclPymtCondForRcvngBank"/>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank">
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '1/1' or ../SequenceTotal = '1/2' or ../SequenceTotal = '1/3' or ../SequenceTotal = '1/4' or ../SequenceTotal = '1/5' or ../SequenceTotal = '1/6' or ../SequenceTotal = '1/7' or ../SequenceTotal = '1/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4' or ../SequenceTotal = '2/5' or ../SequenceTotal = '2/6' or ../SequenceTotal = '2/7' or ../SequenceTotal = '2/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4' or ../SequenceTotal = '3/5' or ../SequenceTotal = '3/6' or ../SequenceTotal = '3/7' or ../SequenceTotal = '3/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '4/4' or ../SequenceTotal = '4/5' or ../SequenceTotal = '4/6' or ../SequenceTotal = '4/7' or ../SequenceTotal = '4/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '5/5' or ../SequenceTotal = '5/6' or ../SequenceTotal = '5/7' or ../SequenceTotal = '5/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '6/6' or ../SequenceTotal = '6/7' or ../SequenceTotal = '6/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '7/7' or ../SequenceTotal = '7/8']"/>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/SpclPymtCondForRcvngBank[../SequenceTotal = '8/8']"/>
				</xsl:if>
			</narrative_special_recvbank>
		</xsl:if>
		<!-- <xsl:apply-templates select="Charges"/> -->
		<xsl:apply-templates select="AdditionalAmountsCovered"/>
	<!-- 	<xsl:apply-templates select="InstrToPayingAccptNegBank"/> -->
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipmentPeriod"/>
	<!-- 	<xsl:apply-templates select="SenderToReceiverInfo"/>		 -->
		
		<bo_comment>
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT780']/AdvisingBankInformation != ''">
			<xsl:text>
				
				ADVISING BANK INFO:
			</xsl:text>
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT780']/AdvisingBankInformation, '\n')"/>
			</xsl:with-param>
	    </xsl:call-template>
	    </xsl:if>	
	    							
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT780']/ConfirmationInformation and ../MeridianMessage[ExternalMessageType = 'MT780']/ConfirmationInformation != ''">
		<xsl:text>
					
		   CONFIRMATION INFORMATION :
		</xsl:text>
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/ConfirmationInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT780']/ChargesInformation and ../MeridianMessage[ExternalMessageType = 'MT780']/ChargesInformation != ''">
		<xsl:text>
					
		   CHARGES INFORMATION :
		</xsl:text>
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT780']/ChargesInformation"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>					
		</bo_comment>	
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT780']/FileIdentification!=''">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT780']/FileIdentification"/>
		</xsl:if>						
	</el_tnx_record>
    </xsl:template>
    
    <xsl:template name="get_cfm_flag">
    	<xsl:param name="input"/>
    	<cfm_flag> 
    	<xsl:choose>
    		<xsl:when test="contains($input, 'WITHOUT')">N</xsl:when>
    		<xsl:when test="contains($input, 'CONFIRM')">Y</xsl:when>
    	</xsl:choose>
    	</cfm_flag> 
	</xsl:template>      
</xsl:stylesheet>
