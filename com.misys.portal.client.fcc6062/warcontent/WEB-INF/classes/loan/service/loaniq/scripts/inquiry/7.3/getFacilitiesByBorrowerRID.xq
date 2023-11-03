declare function getFacilitiesByBorrowerRID($borrower_id){
	<liqInfo>
{for $c in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrower_id)]
return
<borrower>
  <id>{$c/cus/externalId}</id>
  <name>{$c/cus/shortname}</name>
	{LIQ.XQ.UTIL.SET("customerId",$c/cus/id)} 
  {
  for $db in /DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerId)]/Deal  return
    {LIQ.XQ.UTIL.SET("isClosed",$db/dea/isClosed)}
    {LIQ.XQ.UTIL.SET("isClosed",LIQ.XQ.IFTRUE($isClosed, $isClosed,$db/dea/isTerminated))}
   {for $d in $db[LIQ.BO.ISTRUE($isClosed)] return	
  <deal>
    <id>{$d/dea/getDealId}</id>
    <name>{$d/dea/name}</name>
<status>{LIQ.XQ.IFTRUE($d/dea/isClosed, "CLOSED","TERMINATED")}</status>
{LIQ.XQ.UTIL.SET("customerId",$d/dbr/id)} 
    {
    for $f in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)]/Facility
    return
{LIQ.XQ.UTIL.SET("canBeSent", "0")}
{LIQ.XQ.UTIL.SET("canBeSent", LIQ.XQ.IFTRUE($f/fac/isActive,"1",LIQ.XQ.IFTRUE($f/fac/isExpired,"1",LIQ.XQ.IFTRUE($f/fac/isTerminated,"1","0"))))}
{for $d in $f[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($canBeSent,"1"))] return
    <facility>
      <id>{$f/fac/id}</id>
      <name>{$f/fac/name}</name>
      <fcn>{$f/fac/fcn}</fcn>
      <currency>{$f/fac/currency}</currency>
      <total>{$f/fac/globalAvailableAmount}</total>
      <available>{$f/fac/globalAvailToDrawAmount}</available>
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