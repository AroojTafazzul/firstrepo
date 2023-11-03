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
		<lc_ref_id><xsl:value-of select="DocCreditNo"/></lc_ref_id>
		<adv_send_mode>01</adv_send_mode>
		<tnx_type_code>01</tnx_type_code>
		<sub_tnx_type_code/>
		<prod_stat_code>02</prod_stat_code>
		<product_code>EL</product_code>
		<xsl:apply-templates select="DateOfIssue"/>
		<xsl:apply-templates select="DatePlaceExpiry" mode="date"/>
		<amd_date/>
		<amd_no/>
		<xsl:apply-templates select="LatestShipDate"/>
		<tnx_cur_code><xsl:value-of select="substring(CurrencyAmount,1,3)"/></tnx_cur_code>
		<!-- Credit amount -->
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(CurrencyAmount,4)"/></xsl:with-param>
			<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
		</xsl:variable>
		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
		<lc_cur_code><xsl:value-of select="substring(CurrencyAmount,1,3)"/></lc_cur_code>
		<lc_amt><xsl:value-of select="$amount"/></lc_amt>
		<pstv_tol_pct><xsl:value-of select="substring-before(PercentageCreditAmountTolerance,'/')"/></pstv_tol_pct>
		<neg_tol_pct><xsl:value-of select="substring-after(PercentageCreditAmountTolerance,'/')"/></neg_tol_pct>
		<xsl:variable name="positive_tolerance"><xsl:value-of select="substring-before(PercentageCrAmountTolerance,'/')"/></xsl:variable>
		<lc_liab_amt>
			<xsl:choose>
				<xsl:when test="string(number($positive_tolerance))='NaN'"><xsl:value-of select="$amount"/>
				</xsl:when>
				<xsl:otherwise>
				<xsl:choose>
				<xsl:when test="$language = 'fr'">
				<xsl:variable name="localized_amount">
					<xsl:value-of select="translate($amount,',','.')"/>
				</xsl:variable>
				<xsl:value-of select="number(translate($localized_amount,',','')) + number(translate($localized_amount,',','')) * number($positive_tolerance div 100)"/>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="number(translate($amount,',','')) + number(translate($amount,',','')) * number($positive_tolerance div 100)"/>
				</xsl:otherwise>
				</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</lc_liab_amt>
		<lc_type>01</lc_type>
		<xsl:apply-templates select="Beneficiary"/>	
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
		<xsl:apply-templates select="Transhipment"/>
		<xsl:apply-templates select="LoadDispatchTakeCharge"/>
		<xsl:apply-templates select="PortofLoading"/>
		<xsl:apply-templates select="PortofDischarge"/>
		<xsl:apply-templates select="ForTransportTo"/>
		<xsl:call-template name="draft_term"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<cty_of_dest/>
		<rvlv_lc_type_code/>
		<max_no_of_rvlv/>
		<xsl:apply-templates select="PercentageCrAmountTolerance"/>
		
		<xsl:if test="not($swift2018Enabled)">
		<xsl:apply-templates select="MaxCrAmount"/>
		</xsl:if>
		
		<xsl:call-template name="cr_avl_by_code"><xsl:with-param name="payment_type"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>												
		<dir_reim_flag/>
		<xsl:apply-templates select="FormOfDocCredit"/>
		<xsl:apply-templates select="ConfirmationInstructions"/>
		<!-- TODO - Built from the Applicable Rules?
		<eucp_flag/>
		<eucp_version>1.0</eucp_version>
		<eucp_presentation_place/>
		< maturity_date/>
		-->
		<!-- ISSUING BANK -->
		<!-- TODO - Call the reference data to populate the name and address instead of using the BIC for the name only -->
		<issuing_bank_abbv_name/>
		<xsl:variable name="SenderAddressBic" select="concat(substring(SenderAddress,1,8),substring(SenderAddress,10,3))"/>
		<issuing_bank_name><xsl:value-of select="$SenderAddressBic"/></issuing_bank_name>
		<issuing_bank_address_line_1/>
		<issuing_bank_address_line_2/>
		<issuing_bank_dom/>
		<issuing_bank_iso_code><xsl:value-of select="$SenderAddressBic"/></issuing_bank_iso_code>
		<issuing_bank_country><xsl:value-of select="substring($SenderAddressBic,5,2)"/></issuing_bank_country>
		<issuing_bank_reference/>
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
		<credit_available_with_bank_abbv_name/>
		<xsl:choose>
			<xsl:when test="AvailWithByA[. != '']">
				<!-- Option A with BIC -->
				<!-- TODO - The first line contains the BIC code. We should fetch the full name and address from the reference data instead of populating only the name with the BIC -->
				<xsl:variable name="AvailWithByABic" select="substring-before(AvailWithByA,'\n')"/>
				<credit_available_with_bank_name><xsl:value-of select="$AvailWithByABic"/></credit_available_with_bank_name>
				<credit_available_with_bank_address_line_1/>
				<credit_available_with_bank_address_line_2/>
				<credit_available_with_bank_dom/>
				<credit_available_with_bank_iso_code><xsl:value-of select="$AvailWithByABic"/></credit_available_with_bank_iso_code>
			</xsl:when>
			<xsl:otherwise>
				<!-- Option D with name and address -->
				<credit_available_with_bank_name>
				<xsl:call-template name="extract_line">
					<xsl:with-param name="line_number">1</xsl:with-param>
					<xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param>
				</xsl:call-template><!-- <xsl:value-of select="substring-before(AvailWithByD,'\n')"/>--></credit_available_with_bank_name>
				<xsl:variable name="credit_avail_with_bank_line_2">
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">2</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param>
					</xsl:call-template>					
				</xsl:variable>
				<credit_available_with_bank_address_line_1>
					<xsl:if test="not(contains(substring($credit_avail_with_bank_line_2,1,3), 'BY '))">
						<xsl:value-of select="$credit_avail_with_bank_line_2"/>
					</xsl:if>
				</credit_available_with_bank_address_line_1>
				<xsl:variable name="credit_avail_with_bank_line_3">
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">3</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param>
					</xsl:call-template>					
				</xsl:variable>				
				<credit_available_with_bank_address_line_2>
					<xsl:if test="not(contains(substring($credit_avail_with_bank_line_3,1,3), 'BY '))">		
						<xsl:value-of select="$credit_avail_with_bank_line_3"/>
					</xsl:if>
				</credit_available_with_bank_address_line_2>
				<xsl:variable name="credit_avail_with_bank_line_4">
					<xsl:call-template name="extract_line">
						<xsl:with-param name="line_number">4</xsl:with-param>
						<xsl:with-param name="input_text"><xsl:value-of select="AvailWithByD"/></xsl:with-param>
					</xsl:call-template>					
				</xsl:variable>					
				<credit_available_with_bank_dom>	
					<xsl:if test="not(contains(substring($credit_avail_with_bank_line_4,1,3), 'BY '))">
						<xsl:value-of select="$credit_avail_with_bank_line_4"/>
					</xsl:if>
				</credit_available_with_bank_dom>
				<credit_available_with_bank_iso_code/>
			</xsl:otherwise>
		</xsl:choose>
		<credit_available_with_bank_reference/>
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
		<narrative_description_goods>
			<xsl:apply-templates select="DescOfGoodsAndServices[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DescOfGoodsAndServices[../SequenceOfTotal = '8/8']"/>
		</narrative_description_goods>
		<narrative_documents_required>
			<xsl:apply-templates select="DocumentsRequired[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/DocumentsRequired[../SequenceOfTotal = '8/8']"/>	
		</narrative_documents_required>
		<narrative_additional_instructions>
			<xsl:apply-templates select="AdditionalConditions[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/AdditionalConditions[../SequenceOfTotal = '8/8']"/>	
		</narrative_additional_instructions>
	<xsl:if test="$swift2018Enabled">	
		<xsl:apply-templates select="ReqConfirmPartyA"/>
		<xsl:apply-templates select="ReqConfirmPartyD"/>
		<narrative_special_beneficiary>
			<xsl:apply-templates select="SpecialPaymentBeneficiary[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentBeneficiary[../SequenceOfTotal = '8/8']"/>			
		</narrative_special_beneficiary>
		<narrative_special_recvbank>
			<xsl:apply-templates select="SpecialPaymentReceivingBank[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4' or ../SequenceOfTotal = '1/5' or ../SequenceOfTotal = '1/6' or ../SequenceOfTotal = '1/7' or ../SequenceOfTotal = '1/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4' or ../SequenceOfTotal = '2/5' or ../SequenceOfTotal = '2/6' or ../SequenceOfTotal = '2/7' or ../SequenceOfTotal = '2/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4' or ../SequenceOfTotal = '3/5' or ../SequenceOfTotal = '3/6' or ../SequenceOfTotal = '3/7' or ../SequenceOfTotal = '3/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '4/4' or ../SequenceOfTotal = '4/5' or ../SequenceOfTotal = '4/6' or ../SequenceOfTotal = '4/7' or ../SequenceOfTotal = '4/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '5/5' or ../SequenceOfTotal = '5/6' or ../SequenceOfTotal = '5/7' or ../SequenceOfTotal = '5/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '6/6' or ../SequenceOfTotal = '6/7' or ../SequenceOfTotal = '6/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '7/7' or ../SequenceOfTotal = '7/8']"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT701']/SpecialPaymentReceivingBank[../SequenceOfTotal = '8/8']"/>
		</narrative_special_recvbank>
	</xsl:if>
		<xsl:apply-templates select="Charges"/>
		<xsl:apply-templates select="AddAmtsCovered"/>
		<xsl:apply-templates select="InsToPayAcceptNeg"/>
		<xsl:apply-templates select="PeriodForPresentation"/>
		<xsl:apply-templates select="ShipPeriod"/>
		<xsl:apply-templates select="SenderToReceiverInfo"/>

			<xsl:call-template name="ApplicableRulesLC">
				<xsl:with-param name="rule"><xsl:value-of select="ApplicableRules"/></xsl:with-param>
			</xsl:call-template>
			
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
