declare function getRemittanceDetails($ri,$servGrpId,$db){
{for $scr in /ServicingGroup[LIQ.XQS.EQUAL(@id,$servGrpId)] return
	{LIQ.XQ.UTIL.SET("locationCode",$scr/frg/locationCode)}
}
<remittanceInstruction>			
			<id>{$ri/scr/remittanceInstruction/id}</id>
			<paymentMethod>{$ri/scr/remittanceInstruction/remittanceMethod}</paymentMethod>
			<description>{$ri/scr/remittanceInstruction/description}</description>
			<servicingGroupAlias>{$scr/frg/getServicingGroup/alias}</servicingGroupAlias>
			<accountNo>{$ri/scr/remittanceInstruction/ddaAccountId}</accountNo>
			<locationCode>{$locationCode}</locationCode>
			<currency>{$ri/scr/remittanceInstruction/currency}</currency>
            <standardInd>{$ri/scr/standardInstructionInd}</standardInd>
	{for $prf in $db/dbr/preferredRemittanceInstructions/getRemittanceInstructions return
    {LIQ.XQ.IFTRUE(LIQ.XQS.AND(LIQ.XQS.EQUAL($prf/id,$ri/scr/remittanceInstruction/id),LIQ.XQS.EQUAL($db/dbr/preferredRemittanceInstructions/getServicingGroupId,$scr/frg/getServicingGroup/id)),'<preferredInd>Y</preferredInd>','')}
	}
	{LIQ.XQ.UTIL.GET_RI_BANK_DETAILS($ri/scr/remittanceInstruction)}
</remittanceInstruction> 
};