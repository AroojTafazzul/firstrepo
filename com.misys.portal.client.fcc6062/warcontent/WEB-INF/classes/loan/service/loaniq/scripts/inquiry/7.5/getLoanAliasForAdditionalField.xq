declare function getLoanAliasForAdditionalField($tnxId){
	<liqInfo>
{for $res in /LiqPersistentObjectExtensionAttribute[LIQ.XQS.EQUAL(@valueString,$tnxId)] return
			<name>{$res/oea/name}</name>
			<value>{$res/oea/valueString}</value>
{LIQ.XQ.UTIL.SET("ownerId",$res/oea/ownerId)} 
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@id,$ownerId)] return
<alias>{$ot/ost/alias}</alias>
<id>{$ot/ost/id}</id>
{LIQ.XQ.UTIL.SET("outstandingID", $ot/ost/id)}

{for $otrD in /OutstandingTransaction[LIQ.XQS.EQUAL(@outstandingId,$outstandingID)] return
 {LIQ.XQ.UTIL.SET("statusDesc",LIQ.BO.GetCodeDescription($otrD/otr/objectStateCode,'Object State'))}
    <status>{$statusDesc}</status>
    <transactionId>{$otrD/otr/id}</transactionId>
}
}
}
	</liqInfo>
};
