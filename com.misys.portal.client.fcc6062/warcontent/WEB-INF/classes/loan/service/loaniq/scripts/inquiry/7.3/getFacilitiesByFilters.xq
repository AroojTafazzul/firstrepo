declare function getFacilitiesByFilters($boBorrowerReference,$dealName,$facilityName,$currency,$status) {
	<liqInfo>
	{for $c in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$boBorrowerReference)] return
	<borrower>
	  <id>{$boBorrowerReference}</id>
	  <name>{$c/cus/shortname}</name>
      {LIQ.XQ.UTIL.SET("customerId",$c/cus/id)}
      {LIQ.XQ.UTIL.SET("dealPredicate",'1=1')}
      {LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.UTIL.ADD(LIQ.XQ.UTIL.ADD("DEA_NME_DEAL = '",$dealName),"'"))}
      {LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($dealName,''),'1=1', $dealPredicate))}
	  {for $db in /DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerId)]/Deal[LIQ.SQL.PREDICATE($dealPredicate)]  return
    	{LIQ.XQ.UTIL.SET("isClosed",$db/dea/isClosed)}
	   {for $d in $db[LIQ.BO.ISTRUE($isClosed)] return		  
	  <deal>
    	<id>{$d/dea/getDealId}</id>
	    <name>{$d/dea/name}</name>
		<status>{LIQ.XQ.IFTRUE($d/dea/isClosed, "CLOSED","TERMINATED")}</status>
		{LIQ.XQ.UTIL.SET("customerId",$d/dbr/id)} 
		{LIQ.XQ.UTIL.SET("predicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($activeOrInactive,'ALL'), '1=1', LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($activeOrInactive,"ACTIVE"),"OST_CDE_OBJ_STATE IN ('LRELS')", "OST_CDE_OBJ_STATE NOT IN ('LRELS')")))}
		{LIQ.XQ.UTIL.SET("currencyPredicate",'1=1')}
        {LIQ.XQ.UTIL.SET("currencyPredicate",LIQ.XQ.UTIL.ADD(LIQ.XQ.UTIL.ADD("FAC_CDE_CURRENCY = '",$currency),"'"))}
	    {LIQ.XQ.UTIL.SET("currencyPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($currency,''),'1=1', $currencyPredicate))}
		{LIQ.XQ.UTIL.SET("facNamePredicate",'1=1')}
        {LIQ.XQ.UTIL.SET("facNamePredicate",LIQ.XQ.UTIL.ADD(LIQ.XQ.UTIL.ADD("FAC_NME_FACILITY = '",$facilityName),"'"))}
	    {LIQ.XQ.UTIL.SET("facNamePredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($facilityName,''),'1=1', $facNamePredicate))}
	    {LIQ.XQ.UTIL.SET("statusPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($status,''),'1=1', $status))}
	    {for $f in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)]/Facility[LIQ.SQL.PREDICATE($currencyPredicate)][LIQ.SQL.PREDICATE($facNamePredicate)] return
		 {LIQ.XQ.UTIL.SET("statusPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($status,''),'1=1', $status))}
         {LIQ.XQ.UTIL.SET("statusPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusPredicate,'1=1'),$f/fac/displayStatus, $status))}
         {for $ff in $c[LIQ.XQS.EQUAL($f/fac/displayStatus,$statusPredicate)] return
	    <facility>
			<fcn>{$f/fac/fcn}</fcn>
			<id>{$f/fac/id}</id>
			{LIQ.XQ.UTIL.SET("facilityId",$f/fac/id)}
			<name>{$f/fac/name}</name>
			<currency>{$f/fac/currency}</currency>
			<totalCommitment_amt>{$f/fac/globalAvailableAmount}</totalCommitment_amt>
			<outstandings_amt>{$f/fac/globalCurrentOutstandingAmount}</outstandings_amt>
			<availableToDraw_amt>{$f/fac/globalAvailToDrawAmount}</availableToDraw_amt>
			{for $fbbrw in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)][LIQ.XQS.EQUAL(@facilityId,$facilityId)] return
			 {LIQ.XQ.UTIL.SET("subLimitCount",LIQ.XQ.SIZEOF($fbbrw/fbd,"sublimitLimits"))}
            <sublimit>{LIQ.XQ.IFTRUE(LIQ.XQS.GREATERTHAN($subLimitCount,0),"True","False")}</sublimit>
			 {LIQ.XQ.UTIL.SET("subLimitCount",0)}
			}

			<status>{$f/fac/displayStatus}</status>
			{LIQ.XQ.UTIL.SET("accessCode","NULL")}
			{for $misCode in $f/fac/misCodes return
				{for $item in $misCode[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($misCode/type,"PORTL"))] return
					{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($item/valueType, "MIS Code", "description"))}
				}
			}
			<access_type>{$accessCode}</access_type>
	    </facility>
				{LIQ.XQ.UTIL.SET("statusPredicate",$status)}	
        }
       }
	  </deal>
    }
	}
	</borrower>
	}
	</liqInfo>
};
