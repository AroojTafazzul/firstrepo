declare function getFundingDeskFxrate($facRID,$fromCurr,$toCurr){
	<liqInfo>
		<fxDetails>
		{for $facility in LIQ.BO.GetBOByRID("Facility", $facRID) return
			{LIQ.XQ.UTIL.SET("funDesk",LIQ.BO.GetCodeTableEntry($facility/branch, "Branch", "fundingDesk"))}
			<fundingDesk>{$funDesk}</fundingDesk>
			<fxRate>{LIQ.XQ.UTIL.GET_FUNDING_DESK_FXRATE($fromCurr,$toCurr,$funDesk)}</fxRate>
		}
		</fxDetails>
	</liqInfo>
};
