declare function getInterestDetailForLoan($ost){
<loan>
       <ostId>{$ost/id}</ostId>
       <alias>{$ost/alias}</alias>
	    <interest_rateType>{$ost/pricingOption}</interest_rateType>
		<interest_cycle_frequency>{LIQ.BO.GetCodeDescription($ost/accrualPeriod,'Accrual Period')}</interest_cycle_frequency>
	    <base_rate>{LIQ.XQ.UTIL.MUL($ost/baseRate,100)}</base_rate>
	    <spread>{LIQ.XQ.UTIL.MUL($ost/spread,100)}</spread>
	    <all_in_rate>{LIQ.XQ.UTIL.MUL($ost/allInRate,100)}</all_in_rate>
	    <maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ost/maturityDate)}</maturity_date>
	    <additional_spread>{$ost/additionalSpreadsTotal}</additional_spread>
	    <calculation_method>{$ost/alternateReferenceRatesCalcMethod}</calculation_method>
        <spread_adjustment>{LIQ.XQ.UTIL.MUL($ost/rates/benchmarkAdjRate,100)}</spread_adjustment>
		{LIQ.XQ.UTIL.SET("totalCycleDue", 0.0)}
		{LIQ.XQ.UTIL.SET("totalProjectEOCDue", 0.0)}
		{for $cycle in $ost/accrualBehavior/cycleList return	
			{LIQ.XQ.UTIL.SET("totalCycleDue", LIQ.XQ.UTIL.ADD($totalCycleDue, $cycle/cycleDue))} 
			{LIQ.XQ.UTIL.SET("totalProjectEOCDue", LIQ.XQ.UTIL.ADD($totalProjectEOCDue, $cycle/projectedCycleDue))}
		}
		<total_interest_amount>{$totalCycleDue}</total_interest_amount>
		<totalProjectedEOCamt>{$totalProjectEOCDue}</totalProjectedEOCamt>
	    <currency>{$ost/currency}</currency>
        <facility_currency>{$ost/facilityCurrency}</facility_currency>
		<fx_rate_code_used>{$ost/facilityFxExchange/fundingDeskCode}</fx_rate_code_used>
		<fx_conversion>{$ost/facilityFxExchange/multiplyRate}</fx_conversion>
		<next_repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ost/repricingDate)}</next_repricing_date>
	    <rac_rate>{LIQ.XQ.UTIL.MUL($ost/reserveAssetCostRate,100)}</rac_rate>
	    <current_cycle_start_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$ost/currentCycle/startDate)}</current_cycle_start_date>
	    <cycles>		
     	{LIQ.XQ.UTIL.GET_ACCRUAL_CYCLES($ost/id,'Y')}    	
    	</cycles>
</loan>
};
