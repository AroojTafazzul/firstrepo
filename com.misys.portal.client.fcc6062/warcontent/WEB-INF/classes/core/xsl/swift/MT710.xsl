<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT710 into el_tnx_record. -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common_upload.xsl"/>
   <xsl:param name="reference"/> 
   <xsl:param name="language">en</xsl:param>  
   <xsl:param name="product"/>
   
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
		 
		<xsl:variable name="product_code"><xsl:value-of select="$product"/></xsl:variable>		
		   
		<xsl:variable name="root_node"><xsl:value-of select="$product_code"/>_tnx_record</xsl:variable>
		<xsl:variable name="namepsace"><xsl:text disable-output-escaping="yes">xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/</xsl:text><xsl:value-of select="$product_code"/><xsl:text disable-output-escaping="yes">.xsd"</xsl:text></xsl:variable>
		<xsl:element name="{$root_node}">
        <brch_code>00001</brch_code>
		<lc_ref_id><xsl:value-of select="DocumentaryCreditNumber"/></lc_ref_id>
		<adv_send_mode>01</adv_send_mode>
		<tnx_type_code>01</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>02</prod_stat_code>
		<product_code>EL</product_code>
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="date"/>
		<xsl:apply-templates select="DateAndPlaceOfExpiry" mode="place"/>
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
		<lc_liab_amt>
			<xsl:choose>
				<xsl:when test="string(number($positive_tolerance))='NaN'"><xsl:value-of select="$amount"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="number(translate($amount,',','')) + number(translate($amount,',','')) * number($positive_tolerance div 100)"/></xsl:otherwise>
			</xsl:choose>
		</lc_liab_amt>
		<lc_type>01</lc_type>
		<xsl:apply-templates select="Benificiary"/>	
		<sec_beneficiary_name/>
		<sec_beneficiary_address_line_1/>
		<sec_beneficiary_address_line_2/>
		<sec_beneficiary_dom/>
		<sec_beneficiary_reference/>
		<xsl:apply-templates select="Applicant"/>
		<xsl:apply-templates select="DatePlaceExpiry" mode="place"/>
		<inco_term/>
		<inco_place/>
		<xsl:apply-templates select="PartialShipments"/>
		<xsl:apply-templates select="Transshipment"/>
		<xsl:apply-templates select="PlcTakChrgDispatchPlcRec"/>
		<xsl:apply-templates select="PlcFinalDestinationTranspPlcDelivery"/>
		<xsl:apply-templates select="LoadDispatchTakeCharge"/>
		<xsl:apply-templates select="PortLoadingAirportDeparture"/>
		<xsl:apply-templates select="PortDischargeAirportDestination"/>
		
		<xsl:apply-templates select="PortofDischarge"/>
		<xsl:apply-templates select="ForTransportTo"/>
		<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<cty_of_dest/>
		<rvlv_lc_type_code/>
		<max_no_of_rvlv/>
		<xsl:apply-templates select="PercentageCreditAmountTolerance"/>
		
		<xsl:if test="not($swift2018Enabled)">	
		<xsl:apply-templates select="MaximumCreditAmount"/>
		</xsl:if>
		
		<xsl:apply-templates select="AdditionalAmountsCovered"/>
			
		<xsl:call-template name="cr_avl_by_code"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<dir_reim_flag/>
		<xsl:apply-templates select="FormOfDocumentaryCredit"/>
		<xsl:apply-templates select="ConfirmationInstructions"/>
		<!-- ISSUING BANK -->
		<!-- TODO - Call the reference data to populate the name and address instead of using the BIC for the name only -->
		<issuing_bank_abbv_name/>
		<issuing_bank_name>		
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="IssuingBankA"/></xsl:with-param>
		</xsl:call-template></issuing_bank_name>
		<issuing_bank_address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="IssuingBankA"/></xsl:with-param>
		</xsl:call-template></issuing_bank_address_line_1>
		<issuing_bank_address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="IssuingBankA"/></xsl:with-param>
		</xsl:call-template></issuing_bank_address_line_2>
		<issuing_bank_dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="IssuingBankA"/></xsl:with-param>
		</xsl:call-template>
		</issuing_bank_dom>
	
		<!-- ADVISE THRU BANK -->
		<advise_thru_bank_abbv_name/>
		<xsl:choose>
			<xsl:when test="AdviseThruBankA[. != '']">
				<!-- Option A with BIC -->
				<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
				<xsl:variable name="AdviseThruBankABic">
					<xsl:choose>
						<xsl:when test="substring(AdviseThruBankA,1,1) = '/'">
							<xsl:value-of select="substring-after(AdviseThruBankA,'\n')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="AdviseThruBankA"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- TODO - We should fetch the full name and address from the reference data instead of populating only the name with the BIC -->
				<advise_thru_bank_name><xsl:value-of select="$AdviseThruBankABic"/></advise_thru_bank_name>
				<advise_thru_bank_address_line_1/>
				<advise_thru_bank_address_line_2/>
				<advise_thru_bank_dom/>
				<advise_thru_bank_iso_code><xsl:value-of select="$AdviseThruBankABic"/></advise_thru_bank_iso_code>
			</xsl:when>
			<xsl:when test="AdviseThruBankB[. != '']">
				<!-- Option B with location-->
				<xsl:variable name="AdviseThruBankBLocation">
					<xsl:choose>
						<xsl:when test="substring(AdviseThruBankB,1,1) = '/'">
							<xsl:value-of select="substring-after(AdviseThruBankB,'\n')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="AdviseThruBankB"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<advise_thru_bank_name><xsl:value-of select="substring-before($AdviseThruBankBLocation,'\n')"/></advise_thru_bank_name>
				<advise_thru_bank_address_line_1></advise_thru_bank_address_line_1>
				<advise_thru_bank_address_line_2></advise_thru_bank_address_line_2>
				<advise_thru_bank_dom></advise_thru_bank_dom>
				<advise_thru_bank_iso_code/>				
			</xsl:when>
			<xsl:otherwise>
				<!-- Option D with name and address -->
				<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
				<xsl:variable name="AdviseThruBankDNameAddress">
					<xsl:choose>
						<xsl:when test="substring(AdviseThruBankD,1,1) = '/'">
							<xsl:value-of select="substring-after(AdviseThruBankD,'\n')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="AdviseThruBankD"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<advise_thru_bank_name>
				<xsl:call-template name="extract_line">
					<xsl:with-param name="line_number">1</xsl:with-param>
					<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
				</xsl:call-template><!-- <xsl:value-of select="substring-before($AdviseThruBankDNameAddress,'\n')"/>--></advise_thru_bank_name>
				<advise_thru_bank_address_line_1>
				<xsl:call-template name="extract_line">
					<xsl:with-param name="line_number">2</xsl:with-param>
					<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
				</xsl:call-template></advise_thru_bank_address_line_1>
				<advise_thru_bank_address_line_2>
				<xsl:call-template name="extract_line">
					<xsl:with-param name="line_number">3</xsl:with-param>
					<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
				</xsl:call-template></advise_thru_bank_address_line_2>
				<advise_thru_bank_dom>
				<xsl:call-template name="extract_line">
					<xsl:with-param name="line_number">1</xsl:with-param>
					<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
				</xsl:call-template></advise_thru_bank_dom>
				<advise_thru_bank_iso_code/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- CREDIT AVAILABLE WITH BANK -->
		<!-- CREDIT AVAILABLE WITH BANK -->		
		<xsl:apply-templates select="AvailableWithByA"/>	
		<xsl:apply-templates select="AvailableWithByD"/>
		
		
		<!-- DRAWEE DETAILS BANK -->
		<drawee_details_bank_abbv_name/>
		<xsl:choose>
			<xsl:when test="DraweeA[. != '']">
				<!-- Option A with BIC -->
				<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
				<xsl:variable name="DraweeABic">
					<xsl:choose>
						<xsl:when test="substring(DraweeA,1,1) = '/'">
							<xsl:value-of select="substring-after(DraweeA,'\n')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="DraweeA"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- TODO - We should fetch the full name and address from the reference data instead of populating only the name with the BIC -->
				<drawee_details_bank_name><xsl:value-of select="$DraweeABic"/></drawee_details_bank_name>
				<drawee_details_bank_address_line_1/>
				<drawee_details_bank_address_line_2/>
				<drawee_details_bank_dom/>
				<drawee_details_bank_iso_code><xsl:value-of select="$DraweeABic"/></drawee_details_bank_iso_code>
			</xsl:when>
			<xsl:otherwise>
				<!-- Option D with name and address -->
				<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
				<xsl:variable name="DraweeDNameAddress">
					<xsl:choose>
						<xsl:when test="substring(DraweeD,1,1) = '/'">
							<xsl:value-of select="substring-after(DraweeD,'\n')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="DraweeD"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>									
				<drawee_details_bank_name>
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">1</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
					</xsl:call-template>	
				</drawee_details_bank_name>
				<drawee_details_bank_address_line_1>			
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">2</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
					</xsl:call-template></drawee_details_bank_address_line_1>
				<drawee_details_bank_address_line_2>
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">3</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
					</xsl:call-template></drawee_details_bank_address_line_2>
				<drawee_details_bank_dom>					
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">4</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
					</xsl:call-template></drawee_details_bank_dom>
				<drawee_details_bank_iso_code/>
			</xsl:otherwise>
		</xsl:choose>
		<drawee_details_bank_reference/>
		
		<!-- NARRATIVES -->
		<xsl:apply-templates select="InstrToPayingAccptNegBank"/>
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AdditionalAmountsCovered"/>
		
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipmentPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>
		<narrative_description_goods>	
		<xsl:choose>
		<xsl:when test="DescriptionOfGoodsAndServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4'][. != '']">
			<xsl:apply-templates select="DescriptionOfGoodsAndServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
		</xsl:when>
		<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4'][. != '']">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4']"/>
		</xsl:when>
		<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4'][. != '']">
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4']"/>
		</xsl:when>
		<xsl:otherwise test="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '4/4'][. != '']">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/Description[../SequenceTotal = '4/4']"/>
		</xsl:otherwise>
		</xsl:choose>
		</narrative_description_goods>
		<narrative_documents_required>
		<xsl:choose>
		<xsl:when test="DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4'][. != '']">
		<xsl:apply-templates select="DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
		</xsl:when>
		<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4'][. != '']">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4']"/>
		</xsl:when>
		<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4'][. != '']">
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4']"/>
		</xsl:when>
		<xsl:otherwise test="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '4/4'][. != '']">
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/DocumentsRequired[../SequenceTotal = '4/4']"/>
		</xsl:otherwise>
		</xsl:choose>
	</narrative_documents_required>
		<narrative_additional_instructions>
		
		<xsl:choose>
		<xsl:when test="AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4'][. != '']">
		<xsl:apply-templates select="AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
		</xsl:when>
		<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4'][. != '']">
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '2/2' or ../SequenceTotal = '2/3' or ../SequenceTotal = '2/4']"/>
		</xsl:when>
		
		<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4'][. != '']">
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '3/3' or ../SequenceTotal = '3/4']"/>
		</xsl:when>
		<xsl:otherwise test="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '4/4'][. != '']">
		<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT711']/AdditionalConditions[../SequenceTotal = '4/4']"/>
		</xsl:otherwise>
	
		</xsl:choose>
		</narrative_additional_instructions>
		
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AdditionalAmountsCovered"/>
		
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipmentPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
