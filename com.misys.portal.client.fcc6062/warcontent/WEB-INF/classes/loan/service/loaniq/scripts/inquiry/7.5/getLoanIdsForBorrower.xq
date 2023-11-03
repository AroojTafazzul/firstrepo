declare function getLoanIdsForBorrower($borrId,$activeOrInactive,$dealID){
<liqInfo>
<loans>
{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)] return
   {LIQ.XQ.UTIL.SET("customer", $cID/cus)}
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
}
{LIQ.XQ.UTIL.SET("dealPredicate",'1=1')}
{LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.UTIL.ADD(LIQ.XQ.UTIL.ADD("DEA_PID_DEAL = '",$dealID),"'"))}
{LIQ.XQ.UTIL.SET("dealPredicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($dealID,''),'1=1', $dealPredicate))}
{for $d in /DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerID)]/Deal[LIQ.SQL.PREDICATE($dealPredicate)]  return
{LIQ.XQ.UTIL.SET("customerId",$d/dbr/id)} 
	 {for $f in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)]/Facility
    return
		{LIQ.XQ.UTIL.SET("facID", $f/fac/id)}
		{LIQ.XQ.UTIL.SET("predicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($activeOrInactive,'ALL'), '1=1', LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($activeOrInactive,"ACTIVE"),"OST_CDE_OBJ_STATE IN ('LRELS')", "OST_CDE_OBJ_STATE NOT IN ('LRELS',PEND')")))}
		{for $ot in /Outstanding[LIQ.XQS.EQUAL(@facilityId, $facID)][LIQ.XQS.EQUAL(@borrowerId, $customerID)][LIQ.SQL.PREDICATE($predicate)] return
			<lid>{$ot/ost/id}</lid>
		}
	}
}
<borrowerId>{$borrId}</borrowerId>
</loans>
</liqInfo>
};