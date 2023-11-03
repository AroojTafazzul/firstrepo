declare function getLoanHistoryByBorrowerId($borrId,$activeOrInactive){
	<liqInfo>
<loans>
	{for $cID in /Customer[LIQ.XQS.EQUAL(@borrowerIndicator,"Y")][LIQ.XQS.EQUAL(@externalId,$borrId)]
   return
   {LIQ.XQ.UTIL.SET("customer", $cID/cus)}
   {LIQ.XQ.UTIL.SET("customerID", $cID/cus/id)}
   }
 {for $d in /DealBorrower[LIQ.XQS.EQUAL(@customerId, $customerID)]/Deal  return
{LIQ.XQ.UTIL.SET("customerId",$d/dbr/id)} 
	 {for $f in /FacilityBorrower[LIQ.XQS.EQUAL(@borrowerId,$customerId)]/Facility
    return
{LIQ.XQ.UTIL.SET("facID", $f/fac/id)}
{LIQ.XQ.UTIL.SET("predicate",LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($activeOrInactive,'ALL'), '1=1', LIQ.XQ.IFTRUE(LIQ.XQS.EQUAL($activeOrInactive,"ACTIVE"),"OST_CDE_OBJ_STATE IN ('LRELS')", "OST_CDE_OBJ_STATE NOT IN ('LRELS')")))}
{for $ot in /Outstanding[LIQ.XQS.EQUAL(@facilityId, $facID)][LIQ.XQS.EQUAL(@borrowerId, $customerID)][LIQ.SQL.PREDICATE($predicate)] return
       <ln_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.misys.com/mtp/interfaces/xsd/ln.xsd">
	<bo_ref_id>{$ot/ost/alias}</bo_ref_id>
	<status>{LIQ.XQ.IFTRUE($ot/ost/isActive,"ACTIVE","INACTIVE")}</status>
  <bo_tnx_id>{$ot/ost/id}</bo_tnx_id>
  <bo_deal_id>{$ot/ost/dealId}</bo_deal_id>
  <bo_deal_name>{$ot/ost/dealName}</bo_deal_name>
  <bo_facility_id>{$ot/ost/facilityId}</bo_facility_id>
  <bo_facility_name>{$ot/ost/facilityName}</bo_facility_name>
  <borrower_reference>{LIQ.BO.GetBOByRID("Customer", $ot/ost/borrowerId)/externalId}</borrower_reference>
  <effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $ot/ost/effectiveDate)}</effective_date>
  <ln_liab_amt>{$ot/ost/currentAmount}</ln_liab_amt>
  <ln_amt>{$ot/ost/originalAmount}</ln_amt>
  <ln_cur_code>{$ot/ost/currency}</ln_cur_code>
  <ln_maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $ot/ost/maturityDate)}</ln_maturity_date>
  <pricing_option>{$ot/ost/pricingOption}</pricing_option>
  <product_code>LN</product_code>
  <rate>{$ot/ost/outstanding/rates/baseRate}</rate>
  <match_funding>{LIQ.XQ.IFTRUE($ot/ost/getIsMatchFunded,'Y','N')}</match_funding>  
  <repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $ot/ost/repricingDate)}</repricing_date>
  <repricing_frequency>{$ot/ost/repricingFrequency}</repricing_frequency>
  <risk_type>{$ot/ost/riskType}</risk_type>
 {LIQ.XQ.UTIL.SET("outStandingID", $ot/ost/id)}
{for $otrD in /OutstandingTransaction[LIQ.XQS.EQUAL(@type,"RCMF")][LIQ.XQS.EQUAL(@outstandingId,$outStandingID)] return
    <loan_repricing_trans_rid>{$otrD/otr/id}</loan_repricing_trans_rid>
}
{for $otrD in /OutstandingTransaction[LIQ.XQS.EQUAL(@type,"ID")][LIQ.XQS.EQUAL(@outstandingId,$outStandingID)] return
    <drawdown_rrid>{$otrD/otr/id}</drawdown_rrid>
}
  <tnx_type_code>62</tnx_type_code>
  <prod_stat_code>07</prod_stat_code>
  <tnx_stat_code>04</tnx_stat_code>
       </ln_tnx_record>
}
}
}
</loans>
</liqInfo>
};