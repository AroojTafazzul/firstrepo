<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
    <!-- TEMPLATE String Replace -->
	<xsl:template name="backslashn_replace">
		<xsl:param name="input_text"/>
		<xsl:variable name="backslashn">\n</xsl:variable>
		<xsl:variable name="cr"><xsl:text>
</xsl:text></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input_text,$backslashn)">
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text" select="substring-before($input_text,$backslashn)"/>
				</xsl:call-template><xsl:value-of select="$cr"/><xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text" select="substring-after($input_text,$backslashn)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input_text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
<!-- 
  String replace
  
  Note that the value of cr is a hard carriage return - tidying the markup here
  will break the template
  -->
 <xsl:template name="string_replace">
  <xsl:param name="input_text"/>
  <xsl:variable name="cr"><xsl:text>
</xsl:text></xsl:variable>
  <xsl:choose>
   <xsl:when test="contains($input_text,$cr)">
    <!--Call the template in charge of replacing the spaces by NBSPs-->
	<xsl:call-template name="space_replace">
     <xsl:with-param name="input_text" select="substring-before($input_text,$cr)"/>
    </xsl:call-template>
    <br/>
    <xsl:call-template name="string_replace">
     <xsl:with-param name="input_text" select="substring-after($input_text,$cr)"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="space_replace">
     <xsl:with-param name="input_text" select="$input_text"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>	
 
  <!-- 
   -->
  <xsl:template name="space_replace">
   <xsl:param name="input_text"/>
   <xsl:choose>
    <xsl:when test="contains($input_text,' ')">
     <xsl:value-of select="substring-before($input_text,' ')"/>
     <xsl:text>&nbsp;</xsl:text>
     <xsl:call-template name="space_replace">
      <xsl:with-param name="input_text" select="substring-after($input_text,' ')"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$input_text"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
	
<!-- Format an amount in the user language-->
<!-- Default language is en. it is used to set the amount pattern -->
<!-- Default pattern for the amount is the english pattern ###,###,###,###,##0.000 -->
<xsl:template name="format_amount">
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="amount"><xsl:value-of select="."/></xsl:param>
	<xsl:param name="pattern">###,###,###,###,##0.000</xsl:param>
	<!-- get the amount according to the language -->
	<xsl:variable name="localized_amount">
		<xsl:choose>
			<xsl:when test="$language = 'fr'"><xsl:value-of select="$amount"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="translate($amount,',','.')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- format the amount except for the french amount that is already correct since
	the SWIFT format contains already the comma as the decimal separator -->
	<xsl:choose>
		<xsl:when test="$language = 'fr'"><xsl:value-of select="$localized_amount"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="format-number($localized_amount, $pattern)" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- Extract the payment type from the Meridian XML field -->
<xsl:template name="extract_payment_type">
	<xsl:param name="input_text"><xsl:value-of select="."/></xsl:param>
	<xsl:variable name="backslashn">\n</xsl:variable>	
	<xsl:choose>
			<xsl:when test="contains($input_text,$backslashn)">
				<xsl:choose>
					<xsl:when test="contains(substring-before($input_text,$backslashn), 'BY PAYMENT')">BY PAYMENT</xsl:when>
					<xsl:when test="contains(substring-before($input_text,$backslashn), 'BY ACCEPTANCE')">BY ACCEPTANCE</xsl:when>
					<xsl:when test="contains(substring-before($input_text,$backslashn), 'BY NEGOTIATION')">BY NEGOTIATION</xsl:when>
					<xsl:when test="contains(substring-before($input_text,$backslashn), 'BY DEF PAYMENT')">BY DEF PAYMENT</xsl:when>
					<xsl:when test="contains(substring-before($input_text,$backslashn), 'BY MIXED PYMT')">BY MIXED PYMT</xsl:when>
					<xsl:otherwise><xsl:call-template name="extract_payment_type"><xsl:with-param name="input_text"><xsl:value-of select="substring-after($input_text,$backslashn)"/></xsl:with-param></xsl:call-template></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		<!--  If there no \n in the value, we are at the last line of the "field"-->
		<xsl:otherwise>
		<xsl:choose>
			<xsl:when test="contains($input_text, 'BY PAYMENT')">BY PAYMENT</xsl:when>
			<xsl:when test="contains($input_text, 'BY ACCEPTANCE')">BY ACCEPTANCE</xsl:when>
			<xsl:when test="contains($input_text, 'BY NEGOTIATION')">BY NEGOTIATION</xsl:when>
			<xsl:when test="contains($input_text, 'BY DEF PAYMENT')">BY DEF PAYMENT</xsl:when>
			<xsl:when test="contains($input_text, 'BY MIXED PYMT')">BY MIXED PYMT</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>		
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Get the MTP code of the payment from the credit payment type -->
<xsl:template name="get_cr_avl_by_code">
	<xsl:param name="input_text"/>
	<xsl:choose>
		<xsl:when test="contains($input_text, 'BY PAYMENT')">01</xsl:when>
		<xsl:when test="contains($input_text, 'BY ACCEPTANCE')">02</xsl:when>
		<xsl:when test="contains($input_text, 'BY NEGOTIATION')">03</xsl:when>
		<xsl:when test="contains($input_text,'BY DEF PAYMENT')">04</xsl:when>
		<xsl:when test="contains($input_text, 'BY MIXED PYMT')">05</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>	
</xsl:template>

<!-- Extract the n line of a multi lines field -->
<xsl:template name="extract_line">
	<xsl:param name="line_number">1</xsl:param>
	<xsl:param name="input_text"/>
	<xsl:param name="counter">1</xsl:param>	
	<xsl:variable name="backslashn">\n</xsl:variable>		
	<xsl:choose>
		<xsl:when test="$line_number = $counter ">
			<xsl:choose>
				<xsl:when test="contains($input_text,$backslashn) ">
						<xsl:value-of select="substring-before($input_text,$backslashn)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$input_text"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="counter" select="$counter + 1"/>
				<xsl:with-param name="input_text"><xsl:value-of select="substring-after($input_text,$backslashn)"/></xsl:with-param>
				<xsl:with-param name="line_number"><xsl:value-of select="$line_number"/></xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Format the swift date, target format is dd/mm/yyyy -->
<!-- The date to be formatted must be in the format yymmdd (swift format) -->
<xsl:template name="format_date">
	<xsl:param name="input_date"/>
	<xsl:value-of select="concat(substring($input_date,5,2),'/',substring($input_date,3,2),'/20',substring($input_date,1,2))"/>
</xsl:template>

<!-- Business templates -->
	<xsl:template match="DateOfIssue">
		<iss_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="normalize-space(.)"/></xsl:call-template></iss_date>
	</xsl:template>
	
	<xsl:template match="DatePlaceExpiry|DateAndPlaceOfExpiry" mode="date">	
		<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="."/></xsl:call-template></exp_date>		
	</xsl:template>

	<xsl:template match="LatestShipDate|LatestDateOfShipment">		
		<last_ship_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="normalize-space(.)"/></xsl:call-template></last_ship_date>
	</xsl:template>
	
	<xsl:template match="Beneficiary|Benificiary|BeneficiaryBeforeAmend" mode="el">	
		<xsl:param name="index_details"/>
		<beneficiary_name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text">
				<xsl:choose>
					<xsl:when test="contains(.,'/')">
						<xsl:value-of select="substring-after(.,'/')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		</beneficiary_name> 
		<beneficiary_address_line_1>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>		
		</beneficiary_address_line_1>
		<beneficiary_address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></beneficiary_address_line_2>
		<beneficiary_dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></beneficiary_dom>
		<beneficiary_reference>		
			<xsl:call-template name="extract_customer_reference">
				<xsl:with-param name="input">
					<xsl:value-of select="$index_details"/>
				</xsl:with-param>
			</xsl:call-template>
		</beneficiary_reference>
	</xsl:template>	
	
	<xsl:template match="Beneficiary|BeneficiaryBeforeAmend">	
		<beneficiary_name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template>
		</beneficiary_name> 
		<beneficiary_address_line_1>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>		
		</beneficiary_address_line_1>
		<beneficiary_address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></beneficiary_address_line_2>
		<beneficiary_dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></beneficiary_dom>
		<beneficiary_reference/>
	</xsl:template>
	
	<xsl:template match="SecondBeneficiary">	
		<xsl:param name="index_details"/>
		<beneficiary_name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template>
		</beneficiary_name> 
		<beneficiary_address_line_1>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>		
		</beneficiary_address_line_1>
		<beneficiary_address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></beneficiary_address_line_2>
		<beneficiary_dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></beneficiary_dom>
		<!-- <beneficiary_reference><xsl:value-of select="substring-after($index_details, ':47E:BENEFICIARY:')"/></beneficiary_reference>-->
	</xsl:template>		
	
	<xsl:template match="Applicant|FirstBeneficiary">	
		<applicant_name>		
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></applicant_name>
		<applicant_address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></applicant_address_line_1>
		<applicant_address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template></applicant_address_line_2>
		<applicant_dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template>
		</applicant_dom>
	</xsl:template>
	
	<xsl:template match="DatePlaceExpiry|DateAndPlaceOfExpiry" mode="place">	
		<expiry_place><xsl:value-of select="substring(.,7)"/></expiry_place>	
	</xsl:template>
	
	<xsl:template match="PartialShipments">			
		<part_ship_detl><xsl:value-of select="."/></part_ship_detl>
	</xsl:template>
	
	<xsl:template match="Transshipment|Transhipment">			
		<tran_ship_detl><xsl:value-of select="."/></tran_ship_detl>	
	</xsl:template>
	
	<xsl:template match="LoadDispatchTakeCharge|PlcTakChrgDispatchPlcRec|PlaceTakingCharge">		
		<ship_from><xsl:value-of select="."/></ship_from>
	</xsl:template>
	
	<xsl:template match="PortofLoading|PortLoadingAirportDeparture|PortOfDeparture">		
		<ship_loading><xsl:value-of select="."/></ship_loading>
	</xsl:template>
	
	<xsl:template match="PortDischargeAirportDestination">		
		<ship_discharge><xsl:value-of select="."/></ship_discharge>
	</xsl:template>
	
	<xsl:template match="PortofDischarge">		
		<ship_discharge><xsl:value-of select="."/></ship_discharge>
	</xsl:template>
	
	<xsl:template match="ForTransportTo|PlcFinalDestinationTranspPlcDelivery">		
		<ship_to><xsl:value-of select="."/></ship_to>	
	</xsl:template>	
	
	<xsl:template name="draft_term">
		<xsl:param name="payment_type"/>
		<xsl:if test="$payment_type != '' and (DeferredPaymentDetails or MixedPaymentDetails or DraftsAt)">
			<draft_term>
				<xsl:choose>
					<xsl:when test="$payment_type = 'BY DEF PAYMENT' or $payment_type = 'BY DEF PAYMENT'">
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text"><xsl:value-of select="DeferredPaymentDetails"/></xsl:with-param></xsl:call-template>
					</xsl:when>
					<xsl:when test="$payment_type = 'BY MIXED PYMT' or $payment_type = 'BY MIXED PYMT'">
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text"><xsl:value-of select="MixedPaymentDetails"/></xsl:with-param></xsl:call-template>
					</xsl:when>				
					<xsl:otherwise>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text"><xsl:value-of select="DraftsAt"/></xsl:with-param></xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</draft_term>
		</xsl:if>	
	</xsl:template>	
	
	<xsl:template match="PercentageCrAmountTolerance|PercentageCreditAmountTolerance|NewPercentageCrAmountTolerance">		
		<neg_tol_pct><xsl:value-of select="substring-after(.,'/')"/></neg_tol_pct>
		<pstv_tol_pct><xsl:value-of select="substring-before(.,'/')"/></pstv_tol_pct>	
	</xsl:template>	
	
	<xsl:template match="MaxCrAmount|MaximumCreditAmount">		
		<max_cr_desc_code>
			<xsl:if test="contains(., 'NOT EXCEEDING')">3</xsl:if>
		</max_cr_desc_code>
	</xsl:template>
	
	<xsl:template name="cr_avl_by_code">
		<xsl:param name="payment_type"/>	
		<xsl:if test="$payment_type != ''">
			<cr_avl_by_code>
				<xsl:call-template name="get_cr_avl_by_code"><xsl:with-param name="input_text"><xsl:value-of select="$payment_type"/></xsl:with-param></xsl:call-template>
			</cr_avl_by_code>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template match="FormOfDocCredit|FormOfDocumentaryCredit">
		<irv_flag>
			<xsl:choose>
				<xsl:when test="contains(., 'IRREVOC')">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</irv_flag>
		<ntrf_flag>
			<xsl:choose>
				<xsl:when test="contains(., 'TRANS')">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</ntrf_flag>
		<stnd_by_lc_flag>
			<xsl:choose>
				<xsl:when test="contains(., 'STANDBY')">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</stnd_by_lc_flag>
	</xsl:template>
	
	<xsl:template match="ConfirmationInstructions|ConfirmationIns">	
		<cfm_inst_code>
			<xsl:choose>
				<xsl:when test="contains(., 'CONFIRM')">01</xsl:when>
				<xsl:when test="contains(., 'MAY ADD')">02</xsl:when>
				<xsl:otherwise>03</xsl:otherwise>
			</xsl:choose>
		</cfm_inst_code>
	</xsl:template>	
	
	<!-- <xsl:template match="FormOfDocumentaryCredit">	
		<cfm_flag>
			<xsl:choose>
				<xsl:when test="contains(., 'ADDING OUR CONFIRMATION')">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</cfm_flag>
	</xsl:template>-->		
	
	<xsl:template match="DescGoodsServices|DescriptionOfGoodsAndServices|DescOfGoodsAndServices|Description">	
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="DocumentsRequired">			
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="AdditionalConditions">		
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
</xsl:text>
	</xsl:template>
		
	
	<xsl:template match="Charges|ChargesClaimed">	
		<narrative_charges><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</narrative_charges><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="AddAmtsCovered|AdditionalAmountsCovered">	
		<narrative_additional_amount><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</narrative_additional_amount><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="InsToPayAcceptNeg|InstrToPayingAccptNegBank">							
		<narrative_payment_instructions><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</narrative_payment_instructions><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="PeriodForPresentation">
		<xsl:variable name="tag_value"><xsl:value-of select="."/></xsl:variable>
		<xsl:if test="contains($tag_value,'/')">
			<period_presentation_days>
				<xsl:value-of select="substring-before($tag_value,'/')"/>
			</period_presentation_days>
			<narrative_period_presentation><xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text"><xsl:value-of select="substring-after($tag_value,'/')"/></xsl:with-param></xsl:call-template>
			</narrative_period_presentation><xsl:text>
</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="ShipPeriod|ShipmentPeriod">			
		<narrative_shipment_period><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</narrative_shipment_period><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="SenderToReceiverInfo|SenderToReceiverInformation">					
		<narrative_sender_to_receiver><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</narrative_sender_to_receiver><xsl:text>
</xsl:text>
	</xsl:template>	
	
	<xsl:template match="SpecialPaymentBeneficiary|SpclPymtCondForBeneficiary">					
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="SpecialPaymentReceivingBank|SpclPymtCondForRcvngBank">					
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
</xsl:text>
	</xsl:template>
	
	<xsl:template match="AmendChrgPayable">	
	<xsl:variable name="charge_code"><xsl:value-of select="."/></xsl:variable>				
		<amd_chrg_brn_by_code>
			<xsl:choose>
				<xsl:when test="contains($charge_code, 'APPL')">01</xsl:when>
				<xsl:when test="contains($charge_code, 'BENE')">02</xsl:when>
				<xsl:when test="contains($charge_code, 'OTHR')">07</xsl:when>
			</xsl:choose>
		</amd_chrg_brn_by_code>
			<xsl:if test="substring-before($charge_code,'/') and contains($charge_code,'/')">
				<narrative_amend_charges_other>
					<xsl:value-of select="substring-after($charge_code,'/')"/>
				</narrative_amend_charges_other>
			</xsl:if>
	</xsl:template>
	
	<xsl:template name="ApplicableRulesLC">
		<xsl:param name="rule"/>
    	<applicable_rules>
	    	<xsl:choose>
	    		<xsl:when test="contains($rule, 'EUCP LATEST VERSION')">01</xsl:when>
	    		<xsl:when test="contains($rule, 'EUCPURR LATEST VERSION')">02</xsl:when>
	    		<xsl:when test="contains($rule, 'ISP LATEST VERSION')">03</xsl:when>
	    		<xsl:when test="contains($rule, 'UCP LATEST VERSION')">04</xsl:when>
	    		<xsl:when test="contains($rule, 'UCPURR LATEST VERSION')">05</xsl:when>
	    		<xsl:when test="contains($rule, 'OTHR')">99</xsl:when>
	    	</xsl:choose>
	    </applicable_rules>
		<xsl:choose>
			<xsl:when test="substring-before($rule,'/') and contains($rule,'/')">
				<applicable_rules_text>
					<xsl:value-of select="substring-after($rule,'/')"/>
				</applicable_rules_text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CancellationRequest">
		<cancellation_req_flag>
			<xsl:choose>
				<xsl:when test="contains(., 'CANCEL')">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</cancellation_req_flag>
	</xsl:template>
	
	<xsl:template name="FirstAdvisingBankA">
	<xsl:param name="bank"/>
	<xsl:param name="reference"/>
		<first_advising_bank>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankA_bic">
			<xsl:choose>
				<xsl:when test="substring($bank,1,1) = '/'">
					<xsl:value-of select="substring-after($bank,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$bank"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		<reference><xsl:value-of select="$reference"/>
		</reference>
		</first_advising_bank>	
	</xsl:template>	
	<xsl:template name="FirstAdvisingBankD">
	<xsl:param name="bank"/>
	<xsl:param name="reference"/>
		<first_advising_bank>
		<abbv_name/>	
	<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankd_name_address">
			<xsl:choose>
				<xsl:when test="substring($bank,1,1) = '/'">
					<xsl:value-of select="substring-after($bank,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$bank"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template><!-- <xsl:value-of select="substring-before($AdviseThruBankDNameAddress,'\n')"/>--></name>
		<address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></address_line_1>
		<address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></address_line_2>
		<dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></dom>
		<iso_code/>	
		<reference><xsl:value-of select="$reference"/></reference>
		</first_advising_bank>	
	</xsl:template>
	
	<!-- Advise through bank template used when loading message via the incoming interfaces -->
	<xsl:template match="AdviseThruBankA|AdviseThroughBankA|TransferringBankA">
		<advise_thru_bank>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankA_bic">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		</advise_thru_bank>		
	</xsl:template>
	<xsl:template match="IssuingBankA|IssuingBankOriginalA">
		<issuing_bank>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankA_bic">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		</issuing_bank>	
	</xsl:template>	
	<!-- Advise through bank template used when loading message via the incoming interfaces -->	
	<xsl:template match="AdviseThruBankB|AdviseThroughBankB|TransferringBankB">
		<advise_thru_bank>
		<abbv_name/>	
		<!-- Option B with location-->
		<xsl:variable name="advise_thru_bankB_location">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before(.,'\n')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name><xsl:value-of select="$advise_thru_bankB_location"/></name>
		<address_line_1></address_line_1>
		<address_line_2></address_line_2>
		<dom></dom>
		<iso_code/>	
		</advise_thru_bank>	
	</xsl:template>
	<!-- Advise through bank template used when loading message via the incoming interfaces -->
	<xsl:template match="AdvisingBankA">
		<advising_bank>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankA_bic">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		</advising_bank>		
	</xsl:template>	
	
	<xsl:template match="AdvisingBankD">
		<advising_bank>
		<abbv_name/>	
	<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankd_name_address">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template><!-- <xsl:value-of select="substring-before($AdviseThruBankDNameAddress,'\n')"/>--></name>
		<address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></address_line_1>
		<address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></address_line_2>
		<dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></dom>
		<iso_code/>	
		</advising_bank>		
	</xsl:template>	
	<!-- Advise through bank template used when loading message via the incoming interfaces -->	
	<xsl:template match="AdviseThruBankD|AdviseThroughBankD|TransferringBankD">
		<advise_thru_bank>
		<abbv_name/>	
	<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="AdviseThruBankDNameAddress">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
		</xsl:call-template><!-- <xsl:value-of select="substring-before($AdviseThruBankDNameAddress,'\n')"/>--></name>
		<address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
		</xsl:call-template></address_line_1>
		<address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
		</xsl:call-template></address_line_2>
		<dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$AdviseThruBankDNameAddress"/></xsl:with-param>
		</xsl:call-template></dom>
		<iso_code/>	
		</advise_thru_bank>	
	</xsl:template>	
	<xsl:template match="IssuingBankD|IssuingBankOriginalD">
		<issuing_bank>
		<abbv_name/>	
	<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankd_name_address">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template>
		</name>
		<address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></address_line_1>
		<address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></address_line_2>
		<dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
		</xsl:call-template></dom>
		<iso_code/>	
		</issuing_bank>	
	</xsl:template>
	
	<xsl:template match="AlternativeApplicant">
	<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="alt_name">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<alt_applicant_name>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">1</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$alt_name"/></xsl:with-param>
		</xsl:call-template><!-- <xsl:value-of select="substring-before($AdviseThruBankDNameAddress,'\n')"/>--></alt_applicant_name>
		<alt_applicant_address_line_1>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">2</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$alt_name"/></xsl:with-param>
		</xsl:call-template></alt_applicant_address_line_1>
		<alt_applicant_address_line_2>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">3</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$alt_name"/></xsl:with-param>
		</xsl:call-template></alt_applicant_address_line_2>
		<alt_applicant_dom>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">4</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$alt_name"/></xsl:with-param>
		</xsl:call-template></alt_applicant_dom>
		<alt_applicant_country>
		<xsl:call-template name="extract_line">
			<xsl:with-param name="line_number">5</xsl:with-param>
			<xsl:with-param name="input_text"><xsl:value-of select="$alt_name"/></xsl:with-param>
		</xsl:call-template></alt_applicant_country>
	</xsl:template>
	
	<!-- Available with bank template used when loading message via the incoming interfaces -->	
	<xsl:template match="NominatedConfirmingBankA">
		<credit_available_with_bank>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- TODO - The first line contains the BIC code. We should fetch the full name and address from the reference data instead of populating only the name with the BIC -->
		<xsl:variable name="avail_with_bankA_bic">
			<xsl:choose>
			<xsl:when test="substring(.,1,1) = '/'">
				<xsl:value-of select="substring-after(.,'\n')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
			</xsl:choose>		
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($avail_with_bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$avail_with_bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$avail_with_bankA_bic"/></iso_code>	
		</credit_available_with_bank>
	</xsl:template>
	<xsl:template match="AvailWithByA|AvailableWithByA">
		<credit_available_with_bank>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- TODO - The first line contains the BIC code. We should fetch the full name and address from the reference data instead of populating only the name with the BIC -->
		<xsl:variable name="avail_with_bankA_bic">
			<xsl:value-of select="substring-before(.,'\n')"/>	
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($avail_with_bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$avail_with_bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$avail_with_bankA_bic"/></iso_code>	
		</credit_available_with_bank>
	</xsl:template>
	<!-- Available with bank template used when loading message via the incoming interfaces -->		
	<xsl:template match="AvailWithByD|AvailableWithByD">
		<credit_available_with_bank>
		<abbv_name/>	
		<!-- Option D with name and address -->
		<xsl:variable name="credit_avail_with_bank_name">
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">1</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>					
		</xsl:variable>		
		<name>
			<xsl:value-of select="$credit_avail_with_bank_name"/>
		</name>
		<xsl:if test="not(contains($credit_avail_with_bank_name, 'ANY BANK'))">
		<xsl:variable name="credit_avail_with_bank_line_2">
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>					
		</xsl:variable>
		<address_line_1>
			<xsl:if test="not(contains(substring(normalize-space($credit_avail_with_bank_line_2),1,3), 'BY '))">
				<xsl:value-of select="$credit_avail_with_bank_line_2"/>
			</xsl:if>
		</address_line_1>
		<xsl:variable name="credit_avail_with_bank_line_3">
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">3</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>					
		</xsl:variable>				
		<address_line_2>
			<xsl:if test="not(contains(substring(normalize-space($credit_avail_with_bank_line_3),1,3), 'BY '))">		
				<xsl:value-of select="$credit_avail_with_bank_line_3"/>
			</xsl:if>
		</address_line_2>
		<xsl:variable name="credit_avail_with_bank_line_4">
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">4</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>					
		</xsl:variable>					
		<dom>	
			<xsl:if test="not(contains(substring(normalize-space($credit_avail_with_bank_line_4),1,3), 'BY '))">
				<xsl:value-of select="$credit_avail_with_bank_line_4"/>
			</xsl:if>
		</dom>
		</xsl:if>
		<iso_code/>	
		</credit_available_with_bank>
	</xsl:template>
	<xsl:template match="NominatedConfirmingBankD">
		<credit_available_with_bank>
		<abbv_name/>
		<xsl:variable name="credit_avail_with_bank_name">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">1</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$credit_avail_with_bank_name"/></xsl:with-param>
			</xsl:call-template>
		</name>
		<xsl:if test="not(contains($credit_avail_with_bank_name, 'ANY BANK'))">
			<address_line_1>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$credit_avail_with_bank_name"/></xsl:with-param>
			</xsl:call-template></address_line_1>
			<address_line_2>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">3</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$credit_avail_with_bank_name"/></xsl:with-param>
			</xsl:call-template></address_line_2>
			<dom>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">4</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$credit_avail_with_bank_name"/></xsl:with-param>
			</xsl:call-template></dom>
			<iso_code/>	
		</xsl:if>
		</credit_available_with_bank>
	</xsl:template>	
	<!-- Drawee template used when loading message via the incoming interfaces -->	
	<xsl:template match="DraweeA">
		<drawee_details_bank>
		<abbv_name/>
		<!-- Option A with BIC -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="DraweeABic">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- TODO - We should fetch the full name and address from the reference data instead of populating only the name with the BIC -->
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($DraweeABic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$DraweeABic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$DraweeABic"/></iso_code>	
		</drawee_details_bank>		
	</xsl:template>
	<!-- Drawee template used when loading message via the incoming interfaces -->		
	<xsl:template match="DraweeD">
		<drawee_details_bank>
		<abbv_name/>	
		<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="DraweeDNameAddress">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>									
		<name>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">1</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
			</xsl:call-template>	
		</name>
		<address_line_1>			
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
			</xsl:call-template></address_line_1>
		<address_line_2>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">3</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
			</xsl:call-template></address_line_2>
		<dom>					
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">4</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$DraweeDNameAddress"/></xsl:with-param>
			</xsl:call-template></dom>
		<iso_code/>	
		</drawee_details_bank>	
	</xsl:template>		
	
	<!-- MT707 -->
	<xsl:template match="NewDateExpiry">	
		<exp_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="."/></xsl:call-template></exp_date>
	</xsl:template>
	
	<xsl:template match="DateOfAmend|DateOfIssueOrRequestToIssue|DateOfAmendment">
		<amd_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="."/></xsl:call-template></amd_date>	
	</xsl:template>	
		
	<xsl:template match="DateOfClaimForPayment">
		<app_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="."/></xsl:call-template></app_date>	
	</xsl:template>	

	<xsl:template match="NoOfAmend|NumberOfAmmendment|NumberOfAmendment">
		<amd_no><xsl:value-of select="."/></amd_no>	
	</xsl:template>
	
	<xsl:template name="IncreaseDecreaseDocCrAmount">
		<xsl:if test="IncreaseDocCrAmount or DecreaseDocCrAmount">
			<xsl:variable name="increaserAmt">
				<xsl:choose>
				<xsl:when test="IncreaseDocCrAmount">
					<xsl:value-of select="number(translate(substring(IncreaseDocCrAmount,4),',','.'))"/>
				</xsl:when>
				<xsl:otherwise>0.0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="decreaseAmount">
				<xsl:choose>
				<xsl:when test="DecreaseDocCrAmount">
					<xsl:value-of select="number(translate(substring(DecreaseDocCrAmount,4),',','.'))"/>
				</xsl:when>
				<xsl:otherwise>0.0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<tnx_cur_code>
			<xsl:choose>
			<xsl:when test="IncreaseDocCrAmount">
				<xsl:value-of select="substring(IncreaseDocCrAmount,1,3)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring(DecreaseDocCrAmount,1,3)"/>
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
	
	<xsl:template match="IncreaseDocCrAmount">
		<tnx_amt>
		<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(.,4)"/></xsl:with-param>
		<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>	
		</tnx_amt>	
	</xsl:template>	
	
	<xsl:template match="DecreaseDocCrAmount">
		<tnx_amt>
		<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(.,4)"/></xsl:with-param>
		<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>	
		</tnx_amt>	
	</xsl:template>		
	
	<xsl:template match="AddAmountsCovered">
		<narrative_additional_amount><xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param></xsl:call-template>
		</narrative_additional_amount>
	</xsl:template>	
	
	<xsl:template name="extract_customer_reference">
		<xsl:param name="input"/>
		<xsl:param name="prefix">CUST/</xsl:param>
		<xsl:variable name="backslashn">\n</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input,$backslashn)">
				<xsl:value-of select="substring-before(substring-after($input, $prefix), $backslashn)"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-after($input, $prefix)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="extract_tnx_id">
		<xsl:param name="input"/>
		<xsl:param name="prefix">TNXID/</xsl:param>
		<xsl:variable name="backslashn">\n</xsl:variable>
		<!-- as TNXID/ will be after the customer reference in the tag 78B -->
		<xsl:variable name="tnxId"><xsl:value-of select="substring-after($input, $backslashn)"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($tnxId,$backslashn)">
				<xsl:value-of select="substring-before(substring-after($tnxId, $prefix), $backslashn)"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-after($tnxId, $prefix)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="extract_amount">
		<xsl:param name="input"/>
		<xsl:param name="prefix">TRNAMT/</xsl:param>
		<xsl:variable name="backslashn">\n</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input,$backslashn)">
				<xsl:value-of select="substring-before(substring-after($input, $prefix), $backslashn)"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-after($input, $prefix)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="extract_exp_date">
		<xsl:param name="input"/>
		<xsl:param name="prefix">EXPDT/</xsl:param>
		<xsl:variable name="slash">/</xsl:variable>
		<xsl:variable name="backslashn">\n</xsl:variable>
		<xsl:choose>
			<xsl:when test="contains($input,$backslashn)">
				<xsl:value-of select="substring-before(substring-after($input, $prefix), $slash)"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-after($input, $prefix)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="DetailsOfOwnCommissionAndCharges|DetailsCharges|ChargesDeducted">
		<xsl:variable name="backslashn">\n</xsl:variable>	
		<xsl:choose>
			<xsl:when test="substring(.,1,1) = '/'">
				<xsl:call-template name="create_charge">
					<xsl:with-param name="input" select="."/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<charge>
				<chrg_code>OTHER</chrg_code>
				<amt/>
				<cur_code/>
				<status></status>
				<additional_comment>
					<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="."/>
					</xsl:with-param>
					</xsl:call-template>
				</additional_comment>
				<created_in_session>Y</created_in_session>
				</charge>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="create_charge">
		<xsl:param name="input"/>
		<xsl:variable name="backslashn">\n</xsl:variable>		
		<xsl:choose>
			<xsl:when test="contains($input,$backslashn)">
				<xsl:call-template name="create_charge">
					<xsl:with-param name="input" select="substring-before($input,$backslashn)"/>
				</xsl:call-template>
				<xsl:call-template name="create_charge">
					<xsl:with-param name="input" select="substring-after($input,$backslashn)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="chrgcode">
					<xsl:value-of select="substring-before(substring-after($input,'/'), '/')"/>
				</xsl:variable>
				<charge>
				<chrg_code>
					<xsl:choose>
					<xsl:when test="$chrgcode = 'ISSUECHG'">ISSFEE</xsl:when>
					<xsl:when test="$chrgcode = 'PAYMTCHG'">COMMISSION</xsl:when>																
					<xsl:otherwise>OTHER</xsl:otherwise>
					</xsl:choose>
				</chrg_code>
				<!-- Check if the 4th characters is a number, if yes, we assume
				that a mount is defined -->
				<xsl:variable name="amount"><xsl:value-of select="substring-after($input, $chrgcode)"/></xsl:variable>
				<xsl:if test="string(number(substring($amount , 5,1))) !='NaN'">
					<amt>
					<xsl:call-template name="format_amount">
					<xsl:with-param name="amount"><xsl:value-of select="substring($amount ,5, 13)"/></xsl:with-param>
					</xsl:call-template>
					</amt>
					<cur_code><xsl:value-of select="substring($amount,2,3)"/></cur_code>
				</xsl:if>
				<status>01</status>
				<created_in_session/>
				</charge>
			</xsl:otherwise>
		</xsl:choose>			
	</xsl:template>
	
	<xsl:template match="DocumentDispatch">
		<xsl:param name="input_text"/>
		<xsl:choose>
			<xsl:when test="$input_text = 'AIRM'">The documents will be dispatched to the issuing bank by airmail.</xsl:when>
			<xsl:when test="$input_text = 'COUR'">The documents will be dispatched to the issuing bank by courier.</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>	
	</xsl:template>	
	
	<xsl:template match="FileIdentification">
		<xsl:variable name="fileName"><xsl:value-of select="substring-after(.,'/')"/></xsl:variable>
		<delivery_channel>
			<xsl:value-of select="substring-before(., '/')"/>
		</delivery_channel>
		<attachments>
			<attachment>
				<description><xsl:value-of select="$fileName"/></description>
				<file_name><xsl:value-of select="$fileName"/></file_name>
				<title>MT798 Attachment</title>				
			</attachment>
		</attachments>	
	</xsl:template>				
	
	<xsl:template match="FurtherIdentification">
		<xsl:param name="input_text"/>
		<xsl:choose>
			<xsl:when test="$input_text = 'ACCEPT'">04</xsl:when>
			<xsl:when test="$input_text = 'DEBIT'">04</xsl:when>
			<xsl:when test="$input_text = 'NEGOTIATE'">04</xsl:when>
			<xsl:when test="$input_text = 'REIMBURSE'">04</xsl:when>
			<xsl:when test="$input_text = 'REMITTED'">04</xsl:when>
			<xsl:when test="$input_text = 'SEE72'">04</xsl:when>			
			<xsl:otherwise>04</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>	
	
	<xsl:template name="PaymentTerms">
		<xsl:param name="input_text"/>
		<xsl:choose>
			<xsl:when test="$input_text = 'SGHT'">BY SIGHT PAYMENT</xsl:when>
			<xsl:when test="$input_text = 'ACCT'">BY ACCEPTANCE</xsl:when>
			<xsl:when test="$input_text = 'DEFP'">BY DEFERRED PAYMENT</xsl:when>
			<xsl:when test="$input_text = 'MIXD'">BY MIXED PAYMENT</xsl:when>
			<xsl:when test="$input_text = 'NEGN'">NEGOTIATION</xsl:when>			
		</xsl:choose>	
	</xsl:template>		
	
	<xsl:template name="PaymentLiability">
		<xsl:param name="input_text"/>
		<xsl:choose>
			<xsl:when test="$input_text = 'BPOB'">PAYMENT WITH OBLIGATION TO PAY</xsl:when>
			<xsl:when test="$input_text = 'NOOB'">PAYMENT WITHOUT OBLIGATION TO PAY</xsl:when>		
		</xsl:choose>	
	</xsl:template>						
	
	<xsl:template match="ReqConfirmPartyA|RequestedConfirmationPartyA|ReqConfirmationPartyA">
		<requested_confirmation_party>
		<abbv_name/>	
		<!-- Option A with BIC -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankA_bic">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="bankA_name">
			<xsl:value-of select="service:retrieveBankNameFromIsoCode($bankA_bic)"/>
		</xsl:variable>
		<name>
		<xsl:choose>
		<xsl:when test="$bankA_name != ''">
			<xsl:value-of select="$bankA_name"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$bankA_bic"/>
		</xsl:otherwise>
		</xsl:choose>
		</name>
		<address_line_1/>
		<address_line_2/>
		<dom/>
		<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		</requested_confirmation_party>		
	</xsl:template>	
	
	<xsl:template match="ReqConfirmPartyD|RequestedConfirmationPartyD|ReqConfirmationPartyD">
		<requested_confirmation_party>
		<abbv_name/>	
	<!-- Option D with name and address -->
		<!-- The line not starting with '/' (either the first or second) contains the BIC code. -->
		<xsl:variable name="bankd_name_address">
			<xsl:choose>
				<xsl:when test="substring(.,1,1) = '/'">
					<xsl:value-of select="substring-after(.,'\n')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<name>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">1</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
			</xsl:call-template>
		</name>
		<address_line_1>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
			</xsl:call-template></address_line_1>
		<address_line_2>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">3</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
			</xsl:call-template></address_line_2>
		<dom>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">4</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="$bankd_name_address"/></xsl:with-param>
			</xsl:call-template>
		</dom>
		<iso_code/>	
		</requested_confirmation_party>		
	</xsl:template>
	
	<xsl:template match="MaxCrAmount|MaximumCreditAmount">		
		<max_cr_desc_code>
			<xsl:if test="contains(., 'NOT EXCEEDING')">3</xsl:if>
		</max_cr_desc_code>
	</xsl:template>
	
	<xsl:template match="TextPurpose">
		<provisional_status>
			<xsl:choose>
				<xsl:when test="contains(., 'FINAL')">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</provisional_status>
	</xsl:template>

	<xsl:template match="CreationDateTime | MessageCreationDateTime">
		<bo_release_dttm>	
			<xsl:call-template name="format_msg_creation_date">
				<xsl:with-param name="input_date" select="."/>
			</xsl:call-template>
		</bo_release_dttm>
	</xsl:template>
	
	<xsl:template name="format_msg_creation_date">
		<xsl:param name="input_date"/>
		<xsl:value-of select="concat(substring($input_date,7,2),'/',substring($input_date,5,2),'/',substring($input_date,1,4),' ',substring($input_date,9,2),':',substring($input_date,11,2),':00')"/>
	</xsl:template>

</xsl:stylesheet>