<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT700/MT701(s) into el_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common_upload.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
   <xsl:param name="product"/>
   
   <xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT720']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT720']">
    <!--  get the payment for future use -->
		<xsl:variable name="payment_type">
			<xsl:choose>
				<xsl:when test="AvailWithByA"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByA"/></xsl:with-param></xsl:call-template></xsl:when>
				<xsl:when test="AvailWithByD"><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param></xsl:call-template></xsl:when>
			</xsl:choose>
		</xsl:variable>
		 
		<xsl:variable name="product_code"><xsl:value-of select="$product"/></xsl:variable>		
		   
		<xsl:variable name="root_node"><xsl:value-of select="$product_code"/>_tnx_record</xsl:variable>
		<xsl:variable name="namepsace"><xsl:text disable-output-escaping="yes">xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/</xsl:text><xsl:value-of select="$product_code"/><xsl:text disable-output-escaping="yes">.xsd"</xsl:text></xsl:variable>
		<xsl:element name="{$root_node}">
<!--			 <xsl:attribute name="xsi:noNamespaceSchemaLocation">-->
<!--			 	<xsl:choose>-->
<!--			 		<xsl:when test="$product_code = 'lc'">http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd</xsl:when>-->
<!--			 		<xsl:when test="$product_code = 'el'">http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd</xsl:when>-->
<!--			 	</xsl:choose>-->
<!--    		</xsl:attribute>-->
        <brch_code>00001</brch_code>
		<lc_ref_id><xsl:value-of select="DocumentaryCreditNumber"/></lc_ref_id>
		<adv_send_mode>01</adv_send_mode>
		<bo_ref_id><xsl:value-of select="$reference"/></bo_ref_id>
		<tnx_type_code>01</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>02</prod_stat_code>
		<product_code>EL</product_code>
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:apply-templates select="DatePlaceExpiry" mode="date"/>
		<amd_date/>
		<amd_no/>
		<xsl:apply-templates select="LatestDateOfShipment"/>
		<tnx_cur_code><xsl:value-of select="substring(CcyCodeAmount,1,3)"/></tnx_cur_code>
		<!-- Credit amount -->
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(CcyCodeAmount,4)"/></xsl:with-param>
			<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
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
		<lc_type>01</lc_type>
		<!-- Second beneficiary in an EL transfer -->
		<xsl:apply-templates select="SecondBeneficiary"/>
		<beneficiary_reference>
<!--			<xsl:call-template name="extract_customer_reference">-->
<!--				<xsl:with-param name="input">-->
<!--					<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT782']/AdvisingBankInformation"/>-->
<!--				</xsl:with-param>-->
<!--			</xsl:call-template>-->
		</beneficiary_reference>
		<xsl:apply-templates select="FirstBeneficiary"/>
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="place"/>
		<inco_term/>
		<inco_place/>
		<xsl:apply-templates select="PartialShipments"/>
		<xsl:apply-templates select="Transhipment"/>
		<xsl:apply-templates select="PlcTakChrgDispatchPlcRec"/>
		<xsl:apply-templates select="PortOfDeparture"/>
		<xsl:apply-templates select="PortofDischarge"/>
		<xsl:apply-templates select="PlcFinalDestinationTranspPlcDelivery"/>
		<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<cty_of_dest/>
		<rvlv_lc_type_code/>
		<max_no_of_rvlv/>
		<xsl:apply-templates select="PercentageCreditAmountTolerance"/>
		
		<xsl:if test="not($swift2018Enabled)">	
		<xsl:apply-templates select="MaximumCreditAmount"/>	
		</xsl:if>
		
		<xsl:call-template name="cr_avl_by_code"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<dir_reim_flag/>
		<xsl:apply-templates select="FormOfDocumentaryCredit"/>
		<!-- Case MT 720  -->
		<cfm_flag>
			<xsl:choose>
					<xsl:when test="contains(FormOfDocumentaryCredit, 'ADDING OUR CONFIRMATION')">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</cfm_flag>
		<xsl:apply-templates select="ConfirmationInstructions"/>
		<!-- TODO - Built from the Applicable Rules?
		<eucp_flag/>
		<eucp_version>1.0</eucp_version>
		<eucp_presentation_place/>
		< maturity_date/>
		-->
		<!-- ISSUING BANK -->
		<!-- TODO - Call the reference data to populate the name and address instead of using the BIC for the name only -->
<!--		<issuing_bank_abbv_name/>-->
<!--		<xsl:variable name="SenderAddressBic" select="concat(substring(SenderAddress,1,8),substring(SenderAddress,10,3))"/>-->
<!--		<issuing_bank_name><xsl:value-of select="$SenderAddressBic"/></issuing_bank_name>-->
<!--		<issuing_bank_address_line_1/>-->
<!--		<issuing_bank_address_line_2/>-->
<!--		<issuing_bank_dom/>-->
<!--		<issuing_bank_iso_code><xsl:value-of select="$SenderAddressBic"/></issuing_bank_iso_code>-->
<!--		<issuing_bank_country><xsl:value-of select="substring($SenderAddressBic,5,2)"/></issuing_bank_country>-->
<!--		<issuing_bank_reference/>-->
		<xsl:apply-templates select="IssuingBankA"/>
		<xsl:apply-templates select="IssuingBankD"/>
		<xsl:apply-templates select="IssuingBankOriginalA"/>
		<xsl:apply-templates select="IssuingBankOriginalD"/>
		<!-- ADVISE THRU BANK -->
		<xsl:apply-templates select="AdviseThroughBankA"/>
		<xsl:apply-templates select="AdviseThroughBankB"/>	
		<xsl:apply-templates select="AdviseThroughBankD"/>
		<!-- CREDIT AVAILABLE WITH BANK -->
		<xsl:apply-templates select="AvailableWithByA"/>	
		<xsl:apply-templates select="AvailableWithByD"/>
		<!-- DRAWEE DETAILS BANK -->
		<xsl:apply-templates select="DraweeA"/>	
		<xsl:apply-templates select="DraweeD"/>
		<!-- NARRATIVES -->
		<narrative_description_goods>	
			<xsl:apply-templates select="DescGoodsServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescGoodsServices[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescGoodsServices[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DescGoodsServices[../SequenceOfTotal = '4/4']"/>
		</narrative_description_goods>
		<narrative_documents_required>
			<xsl:apply-templates select="DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/DocumentsRequired[../SequenceOfTotal = '4/4']"/>
		</narrative_documents_required>
		<narrative_additional_instructions>
			<xsl:apply-templates select="AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT721']/AdditionalConditions[../SequenceOfTotal = '4/4']"/>
		</narrative_additional_instructions>
		
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AdditionalAmountsCovered"/>
		<xsl:apply-templates select="InstrToPayingAccptNegBank"/>
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipmentPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
