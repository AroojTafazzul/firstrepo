declare function getDocumentsByBorrower($borrId){
<liqInfo>
<pending_docs>
{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)]
   return
   {LIQ.XQ.UTIL.SET("customer", $cID/cus)}
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
   }
{for $docId in /GenericDocument[LIQ.XQS.EQUAL(@categoryCode,"BORRC")][LIQ.XQS.EQUAL(@customerExpectedFromId,$customerID)] return 
{LIQ.XQ.UTIL.SET("status",$docId/ged/objectStateCode)}{LIQ.XQ.UTIL.SET("statusRes",LIQ.XQS.OR(LIQ.XQS.EQUAL($status,"WAIVD"),LIQ.XQS.EQUAL($status,"ARCHV")))}{LIQ.XQ.UTIL.SET("temp",LIQ.XQ.IFTRUE($statusRes,0,1))}
{for $statu in $borrId[LIQ.XQS.NOTEQUAL($temp,0)] return
<pending_bcd_record>
       <document_id>{$docId/ged/id}</document_id>
       <document_type>{LIQ.BO.GetCodeDescription($docId/ged/documentTypeCode,"Document Type")}</document_type>
       <document_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$docId/ged/documentDate)}</document_date>
       <due_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$docId/ged/dueDate)}</due_date>
       <customer>{LIQ.BO.GetBOByRID("Customer", $docId/ged/customerId)/name}</customer>
       <deal> 
              {for $deal in LIQ.BO.GetBOByRID("GenericDocument", $docId/ged/id)/deals return
              <id>{$deal/dealId}</id>
                     <name>{LIQ.BO.GetBOByRID("Deal", $deal/dealId)/name}</name>
              }
       </deal>
</pending_bcd_record>
}}
</pending_docs>
</liqInfo>
};