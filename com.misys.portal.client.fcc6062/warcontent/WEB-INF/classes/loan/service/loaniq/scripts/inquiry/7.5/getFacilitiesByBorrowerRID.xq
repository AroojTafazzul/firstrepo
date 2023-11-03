declare function getFacilitiesByBorrowerRID($borrower_id,$statusInput){
<liqInfo>
{LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusInput,"Active"), " DEA_CDE_DEAL_STAT IN ('CLOSE','AGENT')", "1=1"))}
{LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusInput,"Terminated"), " DEA_CDE_DEAL_STAT IN ('TERM')", $dealPredicate))}
{LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusInput,"Cancelled"), " DEA_CDE_DEAL_STAT IN ('CAN')", $dealPredicate))}
{for $c in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrower_id)] return
<borrower>
  <id>{$c/cus/externalId}</id>
  <name>{$c/cus/shortname}</name>
	{LIQ.XQ.UTIL.SET("customerId",$c/cus/id)} 
{for $db in /DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerId)]/Deal[LIQ.SQL.PREDICATE($dealPredicate)] return
 {LIQ.XQ.UTIL.SET("isClosed",$db/dea/isClosed)}
    {LIQ.XQ.UTIL.SET("isClosed",LIQ.XQ.IFTRUE($isClosed, $isClosed,$db/dea/isTerminated))}
	{LIQ.XQ.UTIL.SET("isClosed",LIQ.XQ.IFTRUE($isClosed, $isClosed,$db/dea/isCancelled))}
   {for $d in $db[LIQ.BO.ISTRUE($isClosed)] return	
  <deal>
     <id>{$db/dea/getDealId}</id> 
    <name>{$db/dea/name}</name>
  <status>{LIQ.XQ.IFTRUE($d/dea/isClosed, "CLOSED",LIQ.XQ.IFTRUE($d/dea/isTerminated,"TERMINATED","CANCELLED"))}</status>
  <currency>{$db/dea/currency}</currency>
  <closingCmt>{$db/dea/globalOriginalAmount}</closingCmt>
{LIQ.XQ.UTIL.SET("customerId",$db/dbr/id)} 
    {for $f in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)]/Facility
    return

{LIQ.XQ.UTIL.SET("statusPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusInput,''),'1=1', $statusInput))}
 {LIQ.XQ.UTIL.SET("statusPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusPredicate,'1=1'),$f/fac/displayStatus, $statusInput))}

{for $d in $f[LIQ.XQS.EQUAL($f/fac/displayStatus,$statusPredicate)] return
    <facility>
      <id>{$f/fac/id}</id>
      <name>{$f/fac/name}</name>
      <fcn>{$f/fac/fcn}</fcn>
      {LIQ.XQ.UTIL.SET("facType",LIQ.XQ.IFTRUE($f/fac/typeObject/isRevolverToTerm,"TERMREV",
		LIQ.XQ.IFTRUE($f/fac/typeObject/isRevolver,"REV","TERM")))}
	  <type>{$facType}</type>
	  <subtype>{$f/fac/subtype}</subtype>
      <currency>{$f/fac/currency}</currency>
      <total>{$f/fac/globalAvailableAmount}</total>
      <available>{$f/fac/globalAvailToDrawAmount}</available>
      <outstandings_amt>{$f/fac/globalCurrentOutstandingAmount}</outstandings_amt>
      <availableToDraw_amt>{$f/fac/globalAvailToDrawAmount}</availableToDraw_amt>
	  <expiryDate>{
        for $date in $f/fac/expirationDate return {
          LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $date)
        }}
      </expiryDate>      
      <maturityDate>{
        for $date in $f/fac/maturityDate return {
          LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $date)
        }}
      </maturityDate>
	   <status>{$f/fac/displayStatus}</status>
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
		  </riskType>
		}
	</riskTypes>
	{for $fborr in /FacilityBorrower[LIQ.XQS.EQUAL(@facilityId,$f/fac/id)] return
	{LIQ.XQ.UTIL.SET("facBorrower",LIQ.XQ.UTIL.INVK_MTHD_PARM($fborr,"getAttributeValue","fbd"))}
	<isSwingline>{LIQ.XQ.UTIL.GET_SWINGLINE($facBorrower)}</isSwingline>
	}
	{LIQ.XQ.UTIL.SET("id", $f/fbd/id)}
	<sublimits>
	{for $fbsl in /BorrowerSublimitLimit[LIQ.XQS.EQUAL(@borrowerId, $id)] return
		 {LIQ.XQ.UTIL.SET("subLimit", LIQ.BO.GetBOByRID("Sublimit",$fbsl/bsl/sublimitId))}
		 {LIQ.XQ.UTIL.SET("facId1",$subLimit/getFacilityId)}
		 {LIQ.XQ.UTIL.SET("facId2",$f/fac/id)}
		 {LIQ.XQ.UTIL.SET("flag",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($facId1, $facId2), 1, 0))}
		 
		 {for $z in $fbsl[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($flag,1))] return
              <sublimit>
			   <sublimit_name>{$fbsl/bsl/name}</sublimit_name>
			   <isSwingLineLenders>{LIQ.XQ.IFTRUE($subLimit/hasSwinglineLenders,"Y", "N")}</isSwingLineLenders>
			    </sublimit>
		 }
	}
	</sublimits>
    </facility>
	}
}
  </deal>
  }
  }
</borrower>
}
</liqInfo>
};
