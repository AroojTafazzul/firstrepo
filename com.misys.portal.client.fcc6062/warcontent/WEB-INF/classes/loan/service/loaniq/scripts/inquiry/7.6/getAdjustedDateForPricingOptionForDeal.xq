declare function getAdjustedDateForPricingOptionForDeal($dealRID,$facRID,$pricingOption,$currency,$date,$dType){
	<liqInfo>
		<dealPricingOption>
			{for $deal in LIQ.BO.GetBOByRID("Deal",$dealRID) return
				<adjustedDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",LIQ.XQ.UTIL.GET_ADJUSTED_DATE_FOR_PRICING_OPTION_FOR_DEAL($deal,$facRID,$pricingOption,$currency,$date,$dType))}</adjustedDate>
			}
		</dealPricingOption>	
	</liqInfo>
};
