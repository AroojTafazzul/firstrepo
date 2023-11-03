declare function getFacilityAvailableAmountOn($fac_rid,$repricing_date) {
<liqInfo>
<facilityDetails>
	<facID>{$fac_rid}</facID>
	{LIQ.XQ.UTIL.SET("facility",LIQ.BO.GetBOByRID("Facility", $fac_rid))}
	{LIQ.XQ.UTIL.GET_FACILITY_AVAILABLE_AMT_ON($fac_rid, $repricing_date)}
</facilityDetails>
</liqInfo>
};
