declare function liq.xq.em.matching.checkforautodoitenabled($event,$trigger){
	{LIQ.XQ.UTIL.LET("releasedFound")}
	{LIQ.XQ.UTIL.SET("releasedFound",0)}
	{LIQ.XQ.UTIL.LET("result")}
	{LIQ.XQ.UTIL.SET("result",0)}
	{for $event in $event/evoOwner/eventsInReverseOrder 
		return {LIQ.XQ.UTIL.SET("releasedFound",LIQ.XQ.IFTRUE(
		LIQ.XQS.EQUAL($releasedFound,0),
		LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($event/actionCode,"RELSD"),1,0),
		$releasedFound
		))}
		{LIQ.XQ.UTIL.SET("result",LIQ.XQ.IFTRUE(
		LIQ.XQS.EQUAL($result,0),
		LIQ.XQ.IFTRUE(LIQ.XQS.AND(LIQ.XQS.EQUAL($event/actionCode,"CSHFL"),LIQ.XQS.EQUAL($releasedFound,0)),1,0),
		$result
		))}
	}
<TriggerMatchingReturnValue result='{LIQ.XQS.EQUAL($result,1)}'/>
};
