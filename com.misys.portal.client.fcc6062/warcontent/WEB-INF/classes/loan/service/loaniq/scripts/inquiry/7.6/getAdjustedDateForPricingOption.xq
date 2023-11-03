declare function getAdjustedDateForPricingOption($facRID,$pricingOption,$currency,$date,$dType){
	<liqInfo>
		<facPricingOption>
		{for $fac in LIQ.BO.GetBOByRID("Facility",$facRID) return
			<adjustedDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",LIQ.XQ.UTIL.GET_ADJUSTED_DATE_FOR_PRICING_OPTION($fac,$pricingOption,$currency,$date,$dType))}</adjustedDate>
		}
		</facPricingOption>
	</liqInfo>
};