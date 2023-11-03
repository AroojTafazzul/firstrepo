declare function getDealsByBorrowerRIDs($borrIds){
<liqInfo>
<borrowerdeals>
{for $rid in LIQ.XQ.UTIL.TOKENIZE($borrIds , ",") return
{for $customer in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$rid)] return
<borrower>
<borrId>{$rid}</borrId>
<borrName>{$customer/cus/name}</borrName>
{for $deals in $customer/cus/loadBorrowerDeals return 
{LIQ.XQ.UTIL.SET("dealName",$deals/dealName)}
  {for $deal in /Deal[LIQ.XQS.EQUAL(@name, $dealName)] return
    {LIQ.XQ.UTIL.SET("isClosed",$deal/dea/isClosed)}
    {LIQ.XQ.UTIL.SET("isClosed",LIQ.XQ.IFTRUE($isClosed, $isClosed,$deal/dea/isTerminated))}
   {for $d in $deal[LIQ.BO.ISTRUE($isClosed)] return	
    <deal>
	<id>{$deal/dea/id}</id>  
	<name>{$deal/dea/name}</name>
        <status>{LIQ.XQ.IFTRUE($deal/dea/isClosed, "CLOSED","TERMINATED")}</status>
  </deal>
  }
}
}</borrower>

}}
</borrowerdeals>
</liqInfo>
};