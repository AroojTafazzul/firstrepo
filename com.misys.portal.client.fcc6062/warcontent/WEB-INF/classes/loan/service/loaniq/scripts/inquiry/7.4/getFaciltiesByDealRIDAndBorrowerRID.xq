declare function getFaciltiesByDealRIDAndBorrowerRID($dealId,$borrId){
<liqInfo>
<facilities>
{for $dealobj in LIQ.BO.GetBOByRID("Deal", $dealId) return
       <deal>        
              <id>{$dealobj/id}</id>
              <name>{$dealobj/name}</name>
       </deal>
       <borrower>
              
		{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)]
		   return
		   {LIQ.XQ.UTIL.SET("customerName", $cID/cus/name)}
		   <id>{$cID/cus/externalId}</id>
		   }
              <name>{$customerName}</name>
       </borrower>

{for $facobj in $dealobj/facilities/Facility[LIQ.XQS.OR(LIQ.XQS.EQUAL(@displayStatus, "Active"),LIQ.XQS.EQUAL(@displayStatus, "Expired"))] return

{LIQ.XQ.UTIL.SET("facId",$facobj/id)}
{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)]
   return
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
   }
{for $borr in /FacilityBorrower[LIQ.XQS.EQUAL(@facilityId, $facId)]/DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerID)] return
{for $d in $borr[LIQ.BO.ISFALSE($facobj/isPendingStatus)] return
       <facility>
              <id>{$facobj/id}</id>
              <name>{$facobj/name}</name>
              <fcn>{$facobj/fcn}</fcn>
               {LIQ.XQ.UTIL.SET("facType",LIQ.XQ.IFTRUE($facobj/typeObject/isRevolverToTerm,"TERMREV",
				LIQ.XQ.IFTRUE($facobj/typeObject/isRevolver,"REV","TERM")))}
              <type>{$facType}</type>
              <subtype>{$facobj/subtype}</subtype>
              <cusip>{$facobj/cusipNumber}</cusip>
              <status>{$facobj/displayStatus}</status>
              <isin>{$facobj/isinNumber}</isin>
              <agreementDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$facobj/agreementDate)}</agreementDate>
              <effectiveDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$facobj/effectiveDate)}</effectiveDate>
              <expiryDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$facobj/expirationDate)}</expiryDate>
              <maturityDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $facobj/maturityDate)}</maturityDate>        
              <mainCurrency>{$facobj/currency}</mainCurrency>
              <globalLimitAmount>{$facobj/globalAvailableAmount}</globalLimitAmount>
              <globalOutstandingAmount>{$facobj/globalCurrentOutstandingAmount}</globalOutstandingAmount>
              <globalAvailableAmount>{$facobj/globalAvailToDrawAmount}</globalAvailableAmount>   
			  {LIQ.XQ.UTIL.SET("funDesk",LIQ.BO.GetCodeTableEntry($facobj/branch, "Branch", "fundingDesk"))}
              {for $cur in $facobj/currenciesDrawsAllowedIn return
				<currency>
					<code>{$cur/currencyCode}</code>
					<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($facobj/currency,$cur/currencyCode,$funDesk)}</fxRate>
				</currency>
 			  }
			{LIQ.XQ.UTIL.SET("accessCode","NULL")}
			{for $misCode in $facobj/misCodes return
				{for $item in $misCode[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($misCode/type,"PORTL"))] return
					{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($item/valueType, "MIS Code", "description"))}
				}
			}
			<access_type>{$accessCode}</access_type>

<riskTypes>
{for $rt in $facobj/riskTypes return
  <riskType>
    <riskCode>{$rt/riskType}</riskCode>
    <riskName>{$rt/name}</riskName>
	{LIQ.XQ.UTIL.SET("isSwingLine",LIQ.BO.GetCodeTableEntry($rt/riskType,"Risk Type","swingLineIndicator"))}
	<isSwingline>{LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($isSwingLine,"Y"),"Y", "N")}</isSwingline>
  </riskType>
}
</riskTypes>
              <borrower>
                     <id>{$borr/dbr/externalId}</id>
                     <name>{$borr/dbr/name}</name>
                     <limitAmount>{$borr/fbd/globalCurrentAmount}</limitAmount>
                  	 {LIQ.XQ.UTIL.SET("drawnAmt", 0)} 
					 {for $ost in /Outstanding[LIQ.XQS.EQUAL(@facilityId,$facId)][LIQ.XQS.EQUAL(@borrowerId,$customerID)][LIQ.XQS.EQUAL(@objectStateCode,"LRELS")] return {LIQ.XQ.UTIL.SET("drawnAmt",LIQ.XQ.UTIL.ADD($ost/ost/getFacilityCurrencyCurrentAmount, $drawnAmt))}}
					 
					 {LIQ.XQ.UTIL.SET("drawnAmt", LIQ.XQ.IFNIL($drawnAmt, 0, $drawnAmt))}
					 <borrDrawnAmt>{$drawnAmt}</borrDrawnAmt>
					 <availableAmtForBorrowerLimit>{LIQ.XQ.UTIL.SUBTRACT($borr/fbd/globalCurrentAmount,$drawnAmt)}</availableAmtForBorrowerLimit>
					 
                     {for $fb in /FacilityBorrower[LIQ.XQS.EQUAL(@facilityId, $facId)]/DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerID)] return
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
	                     <effective_date>{$subLimit/effectiveDate}</effective_date>
	                     <expiry_date>{$subLimit/expirationDateBasic}</expiry_date>
	                     <maturity_date>{$subLimit/maturityDateBasic}</maturity_date>
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
                     {for $fbcl in /FacilityBorrowerCurrencyLimit[LIQ.XQS.EQUAL(@borrowerId, $id)] return
                     <currencyLimit>
                     <currency>{$fbcl/bcl/currencyCode}</currency>
                     <limitAmount>{$fbcl/bcl/limit}</limitAmount>
					 {LIQ.XQ.UTIL.SET("availAmtConverted",LIQ.XQ.UTIL.INVK_MTHD_PARM($fbcl/bcl/owner, "availableForCurrency", $fbcl/bcl/currencyCode))}
					 <availableForCurrency>{LIQ.XQ.UTIL.INVK_MTHD_PARM($facobj, "convertToFacilityCurrencyAmount", $availAmtConverted)}</availableForCurrency>
                     <limitCurrency>{$fbcl/bcl/limitCurrency}</limitCurrency>
					 <limitFXRate>{LIQ.XQ.UTIL.GET_FXRATE_FOR_CURRENCY_LIMIT($fbcl/bcl/businessObject)}</limitFXRate>
                     </currencyLimit>
                     }
                     {for $brtl in /BorrowerRiskTypeLimit[LIQ.XQS.EQUAL(@borrowerId, $id)][LIQ.XQS.EQUAL(@ownerCode, "FBR")] return
			{LIQ.XQ.UTIL.SET("riskTypeCheck",LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "loanIndicator"))}
			{LIQ.XQ.UTIL.SET("swinglineCheck",LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "swingLineIndicator"))}
		    {for $brt1 in $brtl[LIQ.XQS.OR(LIQ.XQS.EQUAL($riskTypeCheck, "Y"),LIQ.XQS.EQUAL($swinglineCheck, "Y"))]  return	
                     <riskTypeLimit>
                     <riskType>{$brtl/brl/riskType}</riskType>
                     <limitAmount>{$brtl/brl/limit}</limitAmount>
					 <borrRiskTypeDrawnAmt>{borrRiskTypeDrawnAmt($facobj/id,$customerID,$brtl/brl/riskType)}</borrRiskTypeDrawnAmt>
					 <availableAmtForRiskTypeLimit>{$brtl/brl/totalAvailable}</availableAmtForRiskTypeLimit>
                     <loan>{LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "loanIndicator")}</loan>
					 <isSwingline>{LIQ.BO.GetCodeTableEntry($brtl/brl/riskType,"Risk Type","swingLineIndicator")}</isSwingline>
                     </riskTypeLimit>
			}
                     }
       </borrower>   
              
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
					<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($facobj/currency,$ipo/pricingCurrency,$funDesk)}</fxRate>
				}
			</facCurrency>
 {LIQ.XQ.UTIL.SET("dealIdForOpt", $facobj/dealId)}
 {LIQ.XQ.UTIL.SET("optName", $ipo/optionName)}
		<dealLevelCurrencies>
		{for $ot in /InterestPricingOption[LIQ.XQS.EQUAL(@dealId, $dealIdForOpt)][LIQ.XQS.EQUAL(@option, $optName)] return
			<currency>
				<code>{$ot/ipo/pricingCurrency}</code>
				{for $poCurrency in $ot/ipo/pricingCurrency return
					<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($facobj/currency,$ot/ipo/pricingCurrency,$funDesk)}</fxRate>
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
       </facility>  
}}}}
</facilities>
</liqInfo>
};
