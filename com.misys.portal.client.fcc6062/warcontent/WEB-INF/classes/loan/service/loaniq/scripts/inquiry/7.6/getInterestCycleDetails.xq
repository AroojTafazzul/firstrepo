declare function getInterestCycleDetails($alias){
	<liqInfo>
	<cycles>
	{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias)] return   
<ostId>{$ot/ost/id}</ostId>
     {LIQ.XQ.UTIL.GET_ACCRUAL_CYCLES($ot/ost/id,'N')}
    }
    </cycles>
	</liqInfo>
};
