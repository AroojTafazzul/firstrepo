declare function getBillsByBorrower($borrId){
<liqInfo>
<bills>
       <borrower>
              
{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)]
   return
   {LIQ.XQ.UTIL.SET("customer", $cID/cus)}
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
   <id>{$cID/cus/externalId}</id>
   }
   		
        <name>{$customer/name}</name>
       </borrower>
       {LIQ.XQ.UTIL.SET("count",0)}
       {for $f in /PersistentBill[LIQ.XQS.EQUAL(@borrowerId, $customerID)][LIQ.SQL.PREDICATE("BTH_CDE_STATUS = 'VIEW' ORDER BY BTH_TSP_REC_CREATE DESC")] return      
       {LIQ.XQ.UTIL.SET("count",LIQ.XQ.NUMBER.SUM($count,1))}

       {for $s in $borrId[LIQ.XQS.LESSTHANOREQUAL($count,9)] return
              <bill>
              <bill_id>{$f/bth/id}</bill_id>
              <bill_date>{LIQ.XQ.FORMAT_TIMESTAMP("%d/%m/%Y",$f/bth/createTimeStamp)}</bill_date>
              <bill_dueDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$f/bth/dateDue)}</bill_dueDate>
              <total_amount>{$f/bth/totalDueAmount}</total_amount>
              <curr_code>{$f/bth/currencyCode}</curr_code>
			  <bill_type>{$f/bth/billTypeCode}</bill_type>
       </bill>
       }
      
}
</bills>
</liqInfo>
};