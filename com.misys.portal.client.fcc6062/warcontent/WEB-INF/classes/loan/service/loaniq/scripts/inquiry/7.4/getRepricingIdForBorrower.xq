declare function getRepricingIdForBorrower($borrId){
<liqInfo>
<loans>
{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)] return
   {LIQ.XQ.UTIL.SET("customer", $cID/cus)}
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
}
{for $loanRepricing in /LoanRepricing[LIQ.XQS.EQUAL(@borrowerId, $customerID)] return
	<repricingId>{$loanRepricing/lrp/id}</repricingId>
}
<borrowerId>{$borrId}</borrowerId>
</loans>
</liqInfo>
};