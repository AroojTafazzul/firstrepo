declare function liq.xq.em.evo.facilityMISCodeChanged($evo){
<facility_access_details>
		<facilityId>{$evo/eventOwner/id}</facilityId>
		{LIQ.XQ.UTIL.SET("accessCode","NULL")}
		{for $misCode in $evo/eventOwner/misCodes return
			{for $item in $misCode[LIQ.BO.ISTRUE(LIQ.XQS.EQUAL($misCode/typeDescription,"Portal MIS code"))] return
				{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($item/valueType, "MIS Code", "description"))}
			}
		}
		<access_type>{$accessCode}</access_type>
</facility_access_details>
};
