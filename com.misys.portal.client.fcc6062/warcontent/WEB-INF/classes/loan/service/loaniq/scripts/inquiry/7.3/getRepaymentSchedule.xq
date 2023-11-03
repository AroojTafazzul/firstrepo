declare function getRepaymentSchedule($alias){
<liqInfo>
{for $ost in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias)] return
<lnRepaymentDetails>
<repaymentType>{$ost/ost/paymentSchedule/balanceTypeDescription}</repaymentType>
<repaymentFrequency>{$ost/ost/paymentSchedule/scheduleTypeDescription}</repaymentFrequency>
<currentOutstandingAmt>{$ost/ost/currentAmount}</currentOutstandingAmt>
<scheduleItems>
	{LIQ.XQ.UTIL.SET("itemCount",0)}   
	{for $schItem in $ost/ost/paymentSchedule/scheduleItems
	return   
		<scheduleItem>
			{LIQ.XQ.UTIL.SET("itemCount",LIQ.XQ.NUMBER.SUM($itemCount,1))}
			<cycleNo>{$itemCount}</cycleNo>
			<paymentAmt>{$schItem/payment}</paymentAmt>
			<interestAmt>{$schItem/interest}</interestAmt>
			<unpaidInterestAmt>{$schItem/unpaidInterestAmount}</unpaidInterestAmt>
			<principleAmt>{$schItem/amount}</principleAmt>
			<unpaidPrincipleAmt>{$schItem/unpaidPrincipalAmount}</unpaidPrincipleAmt>
			<dueDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$schItem/effectiveDate)}</dueDate>
			<remainingAmt>{$schItem/remainingPrincipalBalance}</remainingAmt>    
		</scheduleItem>
	}

</scheduleItems>
</lnRepaymentDetails>
}
</liqInfo>
};
