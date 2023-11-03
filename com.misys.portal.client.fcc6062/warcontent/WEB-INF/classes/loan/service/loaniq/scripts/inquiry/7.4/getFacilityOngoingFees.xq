declare function getFacilityOngoingFees($facility_id,$borrower_id){
	<liqInfo>
{for $f in LIQ.BO.GetBOByRID("Facility", $facility_id)
return
<facility>
	{LIQ.XQ.UTIL.SET("dealId",$f/dealId)}
    <facilityName>{$f/facilityName}</facilityName>
    <borrower>{$f/borrower/externalId}</borrower>
    <dealName>{$f/dealName}</dealName>
    <currency>{$f/currency}</currency>
    <totalCommitmentAmount>{$f/totalCommitmentAmount}</totalCommitmentAmount>
	<expiryDate>{
    	for $date in $f/expirationDate return {
	      LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $f/expirationDate)
	 }}</expiryDate>
	 <maturityDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $f/maturityDate)}</maturityDate>
    <ongoingFees>
    {for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrower_id)] return
    	{LIQ.XQ.UTIL.SET("feePayerName",$cID/cus/shortname)}
	}
	{for $ofpe in /AccruedFee[LIQ.XQS.EQUAL(@facilityId, $facility_id)][LIQ.XQS.EQUAL(@dealId, $dealId)][LIQ.XQS.EQUAL(@category, 'ONG')][LIQ.SQL.PREDICATE("FEE_CDE_OBJ_STATE IN ('RELSD','EXPIR')")] return
    {LIQ.XQ.UTIL.SET("feePayerNameFromFee",$ofpe/fee/feePayerName)}
	{for $ct in $ofpe[LIQ.XQS.EQUAL($feePayerName,$feePayerNameFromFee)] return 
     <ongoingFee>
       <fee>{$ofpe/fee/feeCategory}</fee>
       <feeRID>{$ofpe/fee/id}</feeRID>
       <category>{$ofpe/fee/category}</category>
       <currency>{$ofpe/fee/currency}</currency>
       <type>{$ofpe/fee/type}</type>
       <description>{$ofpe/fee/description}</description>
       <rate>{LIQ.XQ.UTIL.MUL($ofpe/fee/rate,100)}</rate>
       <effectiveDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ofpe/fee/effectiveDate)}</effectiveDate>
       <actualDueDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ofpe/fee/accrualBehavior/actualDueDate)}</actualDueDate>
       <adjustedDueDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ofpe/fee/accrualBehavior/adjustedDueDate)}</adjustedDueDate>
	   <dueAmount>{LIQ.XQ.UTIL.GET_TOTAL_FEE_AMT($ofpe/fee/businessObject)}</dueAmount>
       <actualExpiryDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ofpe/fee/actualExpiryDate)}</actualExpiryDate>
       <originalExpiryDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ofpe/fee/originalExpiryDate)}</originalExpiryDate>
	    {LIQ.XQ.UTIL.SET("statusDesc",LIQ.BO.GetCodeDescription($ofpe/fee/objectStateCode,'Object State'))}
       <status>{LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($statusDesc,"Released"), "Active",$statusDesc)}</status>
	 </ongoingFee>

    }
    }
    </ongoingFees>
</facility>
}
	</liqInfo>
};
