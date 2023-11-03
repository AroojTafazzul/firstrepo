declare function getFacilityDetailsByFacilityRIDandBorrowerRID($facility_id,$borrower_id){
  <liqInfo>
{for $f in /Facility[LIQ.XQS.EQUAL(@id, $facility_id)]
return
{for $d in $f[LIQ.BO.ISFALSE($f/fac/isPendingStatus)] return
<facility>
  <deal>
    {LIQ.XQ.UTIL.SET("dealId",$f/fac/dealId)}
       <id>{$f/fac/dealId}</id>
    <name>{$f/fac/dealName}</name>
  </deal>

  <id>{$f/fac/id}</id>
  <name>{$f/fac/name}</name>
  <fcn>{$f/fac/fcn}</fcn>
  {LIQ.XQ.UTIL.SET("facType",LIQ.XQ.IFTRUE($f/fac/typeObject/isRevolverToTerm,"TERMREV",
LIQ.XQ.IFTRUE($f/fac/typeObject/isRevolver,"REV","TERM")))}
  <type>{$facType}</type>
  <subtype>{$f/fac/subtype}</subtype>
  <cusip>{$f/fac/cusip}</cusip>
<isin>{$f/fac/isin}</isin>

  <agreementDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$f/fac/agreementDate)}</agreementDate>
  <effectiveDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$f/fac/effectiveDate)}</effectiveDate>
  <expiryDate>{
    for $date in $f/fac/expirationDate return {
      LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $f/fac/expirationDate)
  }}</expiryDate>
  <maturityDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $f/fac/maturityDate)}</maturityDate>

  <mainCurrency>{$f/fac/currency}</mainCurrency>
  <globalLimitAmount>{$f/fac/globalAvailableAmount}</globalLimitAmount>
  <globalOutstandingAmount>{$f/fac/globalCurrentOutstandingAmount}</globalOutstandingAmount>
  <globalAvailableAmount>{$f/fac/globalAvailToDrawAmount}</globalAvailableAmount>
  	{LIQ.XQ.UTIL.SET("accessCode","NULL")}
	{for $misCode in $f/fac/misCodes return
		{for $item in $misCode[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($misCode/type,"PORTL"))] return
			{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($item/valueType, "MIS Code", "description"))}
		}
	}
	<access_type>{$accessCode}</access_type>

<riskTypes>
{for $rt in $f/fac/riskTypes return
  <riskType>
    <riskCode>{$rt/riskType}</riskCode>
    <riskName>{$rt/name}</riskName>
	{LIQ.XQ.UTIL.SET("isSwingLine",LIQ.BO.GetCodeTableEntry($rt/riskType,"Risk Type","swingLineIndicator"))}
	<isSwingline>{LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($isSwingLine,"Y"),"Y", "N")}</isSwingline>
</riskType>
}
</riskTypes>
{LIQ.XQ.UTIL.SET("funDesk",LIQ.BO.GetCodeTableEntry($f/fac/branch, "Branch", "fundingDesk"))}
{for $cur in $f/fac/currenciesDrawsAllowedIn return
	<currency>
		<code>{$cur/currencyCode}</code>
		<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($f/fac/currency,$cur/currencyCode,$funDesk)}</fxRate>
	</currency>
}
{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrower_id)]
   return
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
   }

  {for $fb in /FacilityBorrower[LIQ.XQS.EQUAL(@facilityId, $facility_id)]/DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerID)]
  return
  <borrower>
    <id>{$fb/dbr/customerId}</id>
    <name>{$fb/dbr/name}</name>
    <limitAmount>{$fb/fbd/globalCurrentAmount}</limitAmount>
    {LIQ.XQ.UTIL.SET("facDrawnAmt", 0)}
    {for $ost in /Outstanding[LIQ.XQS.EQUAL(@facilityId,$facility_id)][LIQ.XQS.EQUAL(@borrowerId,$customerID)][LIQ.XQS.EQUAL(@objectStateCode,"LRELS")] return 	{LIQ.XQ.UTIL.SET("facDrawnAmt",LIQ.XQ.UTIL.ADD($ost/ost/getFacilityCurrencyCurrentAmount,$facDrawnAmt))}}
    
	{LIQ.XQ.UTIL.SET("facDrawnAmt", LIQ.XQ.IFNIL($facDrawnAmt, 0, $facDrawnAmt))}
	<borrDrawnAmt>{$facDrawnAmt}</borrDrawnAmt>
	<availableAmtForBorrowerLimit>{LIQ.XQ.UTIL.SUBTRACT($fb/fbd/globalCurrentAmount,$facDrawnAmt)}</availableAmtForBorrowerLimit>
       
   {for $fb in /FacilityBorrower[LIQ.XQS.EQUAL(@facilityId, $facility_id)]/DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerID)]
   return
   {LIQ.XQ.UTIL.SET("id", $fb/fbd/id)}
   }

	<sublimits>
    {for $fbsl in /BorrowerSublimitLimit[LIQ.XQS.EQUAL(@borrowerId, $id)] return
             {LIQ.XQ.UTIL.SET("subLimit", LIQ.BO.GetBOByRID("Sublimit",$fbsl/bsl/sublimitId))}
              <sublimit>
                    <sublimit_name>{$fbsl/bsl/name}</sublimit_name>
                     <global_amount>{$fbsl/bsl/limit}</global_amount>
					 <availableAmtForSublimit>{LIQ.XQ.UTIL.SUBTRACT($fbsl/bsl/limit,$subLimit/globalCurrentOutstandingAmountInSublimitCurrency)}</availableAmtForSublimit>
                     <currency>{$fbsl/bsl/currency}</currency>
                     <effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$subLimit/effectiveDate)}</effective_date>
                     <expiry_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$subLimit/expirationDateBasic)}</expiry_date>
                     <maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$subLimit/maturityDateBasic)}</maturity_date>
				<sublimitRiskLimits>
					{for $riskTypeLimit in $fbsl/bsl/getRiskTypeLimits return 
					<sublimitRiskLimit>
						<riskType>{$riskTypeLimit/riskType}</riskType>
						<limitAmtForRiskType>{$riskTypeLimit/limit}</limitAmtForRiskType>
						<borrRiskTypeDrawnAmt>{$riskTypeLimit/getTotalOutstandings}</borrRiskTypeDrawnAmt>
						<availableAmtForRiskType>{$riskTypeLimit/availableForLimit}</availableAmtForRiskType>
						<isSwingline>{LIQ.XQ.IFTRUE($riskTypeLimit/isSwingLineRiskType,"Y", "N")}</isSwingline>
					</sublimitRiskLimit>
					}
				</sublimitRiskLimits>				
              </sublimit>
    }
    </sublimits>

    {for $fbcl in /FacilityBorrowerCurrencyLimit[LIQ.XQS.EQUAL(@borrowerId, $id)]
    return
    <currencyLimit>
      <currency>{$fbcl/bcl/currencyCode}</currency>
      <limitAmount>{$fbcl/bcl/limit}</limitAmount>
      {LIQ.XQ.UTIL.SET("availAmtConverted",LIQ.XQ.UTIL.INVK_MTHD_PARM($fbcl/bcl/owner, "availableForCurrency", $fbcl/bcl/currencyCode))}
	  <availableForCurrency>{LIQ.XQ.UTIL.INVK_MTHD_PARM($f/fac/businessObject, "convertToFacilityCurrencyAmount", $availAmtConverted)}</availableForCurrency>
      <limitCurrency>{$fbcl/bcl/limitCurrency}</limitCurrency>
	  <limitFXRate>{LIQ.XQ.UTIL.GET_FXRATE_FOR_CURRENCY_LIMIT($fbcl/bcl/businessObject)}</limitFXRate>
    </currencyLimit>
    }

    {for $brtl in /BorrowerRiskTypeLimit[LIQ.XQS.EQUAL(@borrowerId, $id)][LIQ.XQS.EQUAL(@ownerCode, "FBR")]  return
 {LIQ.XQ.UTIL.SET("riskTypeCheck",LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "loanIndicator"))}
 {LIQ.XQ.UTIL.SET("swinglineCheck",LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "swingLineIndicator"))}
     {for $brt1 in $brtl[LIQ.XQS.OR(LIQ.XQS.EQUAL($riskTypeCheck, "Y"),LIQ.XQS.EQUAL($swinglineCheck, "Y"))]  return
    <riskTypeLimit>
      <riskType>{$brtl/brl/riskType}</riskType>
      <limitAmount>{$brtl/brl/limit}</limitAmount>
	  <borrRiskTypeDrawnAmt>{borrRiskTypeDrawnAmt($facility_id,$customerID,$brtl/brl/riskType)}</borrRiskTypeDrawnAmt>
	  <availableAmtForRiskTypeLimit>{$brtl/brl/totalAvailable}</availableAmtForRiskTypeLimit>
      <loan>{LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "loanIndicator")}</loan>
	  <isSwingline>{LIQ.BO.GetCodeTableEntry($brtl/brl/riskType,"Risk Type","swingLineIndicator")}</isSwingline>
    </riskTypeLimit>
    }
    }

       {for $o in /Outstanding[LIQ.XQS.EQUAL(@facilityId, $facility_id)][LIQ.XQS.EQUAL(@borrowerId, $customerID)]
       return
       <outstanding>
         <amount>{$o/ost/facilityCurrencyCurrentAmount}</amount>
         <currency>{$o/ost/currency}</currency>
         <riskType>{$o/ost/riskType}</riskType>
	<status>{LIQ.XQ.IFTRUE($o/ost/isActive,"ACTIVE","INACTIVE")}</status>
       </outstanding>
       }
  </borrower>
  }

    {LIQ.XQ.UTIL.SET("dealIpo",$f/fac/dealId)}  
       {LIQ.XQ.UTIL.SET("facobj",LIQ.BO.GetBOByRID("Facility", $facility_id))}
             {LIQ.XQ.UTIL.SET("interestPricingObj", $facobj/interestPricing)}
              {for $ipo in $interestPricingObj/currentPricingExtracts return
              <pricingOption>
       <id>{$ipo/optionName}</id>
       <outstandingType>{LIQ.BO.GetCodeTableEntry($ipo/optionName, "Pricing Option Name", "outstandingType")}</outstandingType>
              <matchFundedIndicator>{LIQ.BO.GetCodeTableEntry($ipo/optionName,"Pricing Option Name","matchFundedInd")}</matchFundedIndicator>
              <maturityDateMandatory>{LIQ.BO.GetCodeTableEntry($ipo/optionName,"Pricing Option Name","maturityExpiryRequired")}</maturityDateMandatory>
			{LIQ.XQ.UTIL.SET("repricingDateApplies", LIQ.BO.GetCodeTableEntry($ipo/optionName,"Pricing Option Name","repricingDateInd"))}
			{for $ifRepricingDateApplies in $ipo[LIQ.XQS.EQUAL($repricingDateApplies, "Y")] return
              {LIQ.XQ.UTIL.SET("pricingOption",$ipo/optionName)} 
              {LIQ.XQ.UTIL.SET("facRID",$facobj/id)}
              {LIQ.XQ.UTIL.SET("rfFlag","false")}
              {for $porf in /LiqMNFacilityPricingOptionRepricingFrequency[LIQ.XQS.EQUAL(@option,$pricingOption)][LIQ.XQS.EQUAL(@facilityId, $facRID)][LIQ.XQS.EQUAL(@dealId,$dealId)] return
				{LIQ.XQ.UTIL.SET("rfFlag","true")}
      			<repricingFrequency>{$porf/frf/frequencyCode}</repricingFrequency> 
       			<interestFrequency>{LIQ.XQ.UTIL.GET_ACCRUAL_PERIOD($porf/frf/frequencyCode)}</interestFrequency>
              }
              {for $porf in /PricingOptionRepricingFrequency[LIQ.XQS.EQUAL(@option, $pricingOption )][LIQ.XQS.EQUAL(@dealId, $dealId)][LIQ.XQS.EQUAL($rfFlag, "false")] return
       			<repricingFrequency>{$porf/rpf/frequencyCode}</repricingFrequency> 
	   			<interestFrequency>{LIQ.XQ.UTIL.GET_ACCRUAL_PERIOD($porf/rpf/frequencyCode)}</interestFrequency>
              }
			}
              
	<facCurrency>
		<code>{$ipo/pricingCurrency}</code>
		{for $poCurrency in $ipo/pricingCurrency return
			<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($f/fac/currency,$ipo/pricingCurrency,$funDesk)}</fxRate>
		}
	</facCurrency>
	 {LIQ.XQ.UTIL.SET("dealIdForOpt", $facobj/dealId)}
	 {LIQ.XQ.UTIL.SET("optName", $ipo/optionName)}
		<dealLevelCurrencies>
		{for $ot in /InterestPricingOption[LIQ.XQS.EQUAL(@dealId, $dealIdForOpt)][LIQ.XQS.EQUAL(@option, $optName)] return
            <currency>
				<code>{$ot/ipo/pricingCurrency}</code>
				{for $poCurrency in $ot/ipo/pricingCurrency return
					<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($f/fac/currency,$ot/ipo/pricingCurrency,$funDesk)}</fxRate>
				}
			</currency>
		}
		</dealLevelCurrencies>
		{LIQ.XQ.UTIL.SET("fipo", LIQ.XQ.UTIL.GET_INTEREST_PRICING_OPTION($facobj, $ipo/optionName))}
		<intentDaysInAdvance>{$fipo/initialNoticeAdvanceDays}</intentDaysInAdvance>
		<nonBusinessDayRule>{$fipo/nonBusinessDayRule}</nonBusinessDayRule>
		<isSwingLinePricingOption>{LIQ.BO.GetCodeTableEntry($ipo/optionName,"Pricing Option Name","swingLineIndicator")}</isSwingLinePricingOption>
              </pricingOption>    
              }
              
  {for $db in /DealBorrower[LIQ.XQS.EQUAL(@productId,$dealId)][LIQ.XQS.EQUAL(@customerId, $customerID)]
   return
   {LIQ.XQ.UTIL.SET("servGrpId",$db/dbr/servicingGroupId)}
   {for $ri in /ServicingGroupRemittanceInstruction[LIQ.XQS.EQUAL(@servicingGroupId,$servGrpId)]      return
                                {LIQ.XQ.IFTRUE(LIQ.XQS.AND(LIQ.XQS.AND(LIQ.XQS.AND(LIQ.XQS.EQUAL($ri/scr/remittanceInstruction/approvalIndicator,LIQ.XQS.EQUAL(1,1)),$ri/scr/getLoanProductIndicator),$ri/scr/getPrincipalIndicator),$ri/scr/getOutgoingTransferIndicator),getRemittanceDetails($ri,$servGrpId,$db),'')}
    }
    
    
} 
</facility>
}
}
</liqInfo>

};