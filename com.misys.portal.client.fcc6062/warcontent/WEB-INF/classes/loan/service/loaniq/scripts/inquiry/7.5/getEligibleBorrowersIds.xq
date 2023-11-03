declare function getEligibleBorrowersIds($borrIds){

	<liqInfo>
	<borrowers>
	{for $rid in LIQ.XQ.UTIL.TOKENIZE($borrIds , ",") return
	{for $c in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$rid)] return
	 <borrower>
	 <id>{$c/cus/externalId}</id>
	 <sublimits>
	{LIQ.XQ.UTIL.SET("customerId",$c/cus/id)} 
{for $db in /DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerId)]/Deal return

 {LIQ.XQ.UTIL.SET("isClosed",$db/dea/isClosed)}
 	 {for $d in $db[LIQ.BO.ISTRUE($isClosed)] return	
		
 		{LIQ.XQ.UTIL.SET("customerId",$d/dbr/id)}
		{LIQ.XQ.UTIL.SET("checkSwing",0)}
 		{for $f in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)]/Facility  return
	
	{LIQ.XQ.UTIL.SET("id", $f/fbd/id)}			
	
	{for $brtl in /BorrowerRiskTypeLimit[LIQ.XQS.EQUAL(@borrowerId, $id)][LIQ.XQS.EQUAL(@ownerCode, "FBR")] return
			{LIQ.XQ.UTIL.SET("riskTypeCheck",LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "loanIndicator"))}
			{LIQ.XQ.UTIL.SET("swinglineCheck",LIQ.BO.GetCodeTableEntry($brtl/brl/riskType, "Risk Type", "swingLineIndicator"))}
		    {for $brt1 in $brtl[LIQ.XQS.OR(LIQ.XQS.EQUAL($riskTypeCheck, "Y"),LIQ.XQS.EQUAL($swinglineCheck, "Y"))]  return	
					 {LIQ.XQ.UTIL.SET("checkSwing", LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($checkSwing, 0), LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($swinglineCheck, "Y"), 1, 0), 1))}
			}
    }
			
			{for $d in $f[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($checkSwing,1))] return	
			{LIQ.XQ.UTIL.SET("checkSwing", 0)}
			{LIQ.XQ.UTIL.SET("interestPricingObj", $f/fac/interestPricing)}
              {for $ipo in $interestPricingObj/currentPricingExtracts return
			  {LIQ.XQ.UTIL.SET("swinglineCheck",LIQ.BO.GetCodeTableEntry($ipo/optionName,"Pricing Option Name","swingLineIndicator"))}
				{LIQ.XQ.UTIL.SET("checkSwing", LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($checkSwing, 0), LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($swinglineCheck, "Y"), 1, 0), 1))}
			  }
			  }
			  
			  {for $d in $f[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($checkSwing,1))] return
	{LIQ.XQ.UTIL.SET("checkSwing", 0)}
			  {for $fbsl in /BorrowerSublimitLimit[LIQ.XQS.EQUAL(@borrowerId, $id)] return
		             {LIQ.XQ.UTIL.SET("subLimit", LIQ.BO.GetBOByRID("Sublimit",$fbsl/bsl/sublimitId))}
						
						{for $riskTypeLimit in $fbsl/bsl/getRiskTypeLimits return 
						
							{LIQ.XQ.UTIL.SET("checkSwing", LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($checkSwing, 1), 1, LIQ.XQ.IFTRUE($riskTypeLimit/isSwingLineRiskType, 1, 0)))}
						}
						
						{LIQ.XQ.UTIL.SET("checkSwing", LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($checkSwing, 1), LIQ.XQ.IFTRUE(LIQ.XQS.ISNOTNULL($subLimit/effectiveDate), LIQ.XQ.IFTRUE(LIQ.XQS.GREATERTHANOREQUAL($subLimit/currentBusinessDate, $subLimit/effectiveDate), 1, 0) , 1), 0))}
						
						{LIQ.XQ.UTIL.SET("checkSwing", LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($checkSwing, 1), LIQ.XQ.IFTRUE(LIQ.XQS.ISNOTNULL($subLimit/expirationDateBasic), LIQ.XQ.IFTRUE(LIQ.XQS.GREATERTHAN($subLimit/expirationDateBasic, $subLimit/currentBusinessDate), 1, 0) , 1), 0))}
						
						{LIQ.XQ.UTIL.SET("checkSwing", LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($checkSwing, 1), LIQ.XQ.IFTRUE(LIQ.XQS.ISNOTNULL($subLimit/maturityDateBasic), LIQ.XQ.IFTRUE(LIQ.XQS.GREATERTHAN($subLimit/maturityDateBasic, $subLimit/currentBusinessDate), 1, 0) , 1), 0))}
						
						{for $d in $fbsl[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($checkSwing,1))] return
							 <sublimit>
							   <sublimit_name>{$fbsl/bsl/name}</sublimit_name>
							   <isSwingLineLenders>{LIQ.XQ.IFTRUE($subLimit/hasSwinglineLenders,"Y", "N")}</isSwingLineLenders>
							 </sublimit>
						}
				
			}	
			}
												
		}
 	}	
	}
	</sublimits>
	</borrower>
}	
	}
	</borrowers>
	</liqInfo>

};