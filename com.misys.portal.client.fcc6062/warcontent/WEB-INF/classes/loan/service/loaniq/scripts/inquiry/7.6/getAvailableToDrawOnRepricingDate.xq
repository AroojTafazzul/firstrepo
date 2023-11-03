declare function getAvailableToDrawOnRepricingDate($fac_rid,$repricing_date) {
<liqInfo>
	<facilityDetails>
		<facID>{$fac_rid}</facID>
		{LIQ.XQ.UTIL.SET("facility",LIQ.BO.GetBOByRID("Facility", $fac_rid))}
		{LIQ.XQ.UTIL.GET_FACILITY_AVAILABLE_AMT_ON($fac_rid, $repricing_date)}
		<AvailableToDrawOnRepricingDate>{SDK.XQ.UTIL.UDF_SUBTRACT($repricing_date,$facility)}</AvailableToDrawOnRepricingDate>
	</facilityDetails>
</liqInfo>
};