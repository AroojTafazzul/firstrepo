declare function getFacilityOngoingFeeDetails($fee_rid,$max,$fromDate,$toDate,$sortOrder){
<liqInfo>
<facilityOngoingFee>
{for $fof in LIQ.BO.GetBOByRID("FeeAccountedFor",$fee_rid)[LIQ.XQS.EQUAL(@category, 'ONG')] return
	<ongoingFeeCycles>
		<FeeEffectiveDate>{$fof/effectiveDate}</FeeEffectiveDate>
		{LIQ.XQ.UTIL.GET_ACCRUAL_CYCLE_DETAILS($fof,$max,$fromDate,$toDate,$sortOrder)}
	</ongoingFeeCycles>
}
</facilityOngoingFee>
</liqInfo>
};
