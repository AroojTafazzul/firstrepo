declare function getBillDataByBillRID($bill){
<liqInfo>
<billDetails>
<details>
{for $o in /PersistentBillData[LIQ.XQS.EQUAL(@header,$bill)] return
{$o/bti/data}
}
</details>
</billDetails>
</liqInfo>
};