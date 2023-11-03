declare function getBillXMLByBillRID($bill){
<liqInfo>
{for $o in /PersistentBillXMLHeader[LIQ.XQS.EQUAL(@billId,$bill)] return {LIQ.XQ.UTIL.SET("xmlBillId",$o/bxh/id)}{for $m in /PersistentBillXMLItem[LIQ.XQS.EQUAL(@header,$xmlBillId)][LIQ.SQL.PREDICATE("1=1 ORDER BY BXI_NUM_SEQUENCE ASC")] return {$m/bxi/data}}}
</liqInfo>
};