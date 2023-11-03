declare function getActualActivityByLoan($alias){
<liqInfo>	{	LIQ.XQ.UTIL.SET("runningBalance",0)}
<activity>
	{for $ost in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias)]
	return	
	<outstandingAlias>{$ost/ost/alias}</outstandingAlias>
	<outstandingType>{$ost/ost/outstandingType}</outstandingType>
        <status>{LIQ.XQ.IFTRUE($ost/ost/isActive,"ACTIVE","INACTIVE")}</status>
	{for $tran in $ost/ost/releasedTransactionsWithInterestPayments
	return
	{for $releasedTrans in $tran[LIQ.BO.ISTRUE($tran/isReleased)]
	return 
    <loanActivity>		
			<releaseDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $releasedTrans/releaseDate)}</releaseDate>
			<effectiveDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $releasedTrans/effectiveDate)}</effectiveDate>
			<description>{$releasedTrans/activityListDescription}</description>
			<globalAmount>{$releasedTrans/amountAbs}</globalAmount>
			<globalCapital>{LIQ.XQ.IFTRUE($releasedTrans/isPrincipalTransaction,$releasedTrans/actualAmountAbs,'0.0')}</globalCapital>
			<globalInterest>{LIQ.XQ.IFTRUE($releasedTrans/isAccrualCyclePayment,$releasedTrans/amount,'0.0')}</globalInterest> 
			{for $obj in $releasedTrans[LIQ.BO.ISTRUE($releasedTrans/isPrincipalTransaction)] return
				{LIQ.XQ.UTIL.SET("runningBalance",LIQ.XQ.UTIL.ADD($runningBalance,$releasedTrans/actualAmount))}
			}
			<globalPrincipal>{$runningBalance}</globalPrincipal>
	</loanActivity>
}		
}
}
</activity>
</liqInfo>
};