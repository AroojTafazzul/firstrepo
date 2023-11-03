declare function getInterestDetails($alias1,$alias2,$alias3,$alias4,$alias5,$alias6,$alias7,$alias8,$alias9,$alias10){
<liqInfo>
<loans>
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias1)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias2)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias3)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias4)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias5)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias6)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias7)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias8)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias9)] return
{getInterestDetailForLoan($ot/ost)}
}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@alias,$alias10)] return
{getInterestDetailForLoan($ot/ost)}
}
</loans>
</liqInfo>
};
