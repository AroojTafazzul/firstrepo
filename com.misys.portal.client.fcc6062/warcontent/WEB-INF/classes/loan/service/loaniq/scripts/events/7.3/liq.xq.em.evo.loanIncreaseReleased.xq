declare function liq.xq.em.evo.loanIncreaseReleased($evo){
<ln_tnx_record
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://www.misys.com/mtp/interfaces/xsd/ln.xsd">
  <bo_ref_id>{$evo/eventOwner/alias}</bo_ref_id>
  <bo_tnx_id>{$evo/eventOwner/id}</bo_tnx_id>
  <bo_deal_id>{$evo/eventOwner/dealId}</bo_deal_id>
  <bo_deal_name>{$evo/eventOwner/dealName}</bo_deal_name>
  <bo_facility_id>{$evo/eventOwner/facilityId}</bo_facility_id>
  <bo_facility_name>{$evo/eventOwner/facilityName}</bo_facility_name>
  <borrower_reference>{LIQ.BO.GetBOByRID("Customer", $evo/eventOwner/borrowerId)/externalId}</borrower_reference>
  <effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $evo/eventOwner/effectiveDate)}</effective_date>
  <ln_cur_code>{$evo/eventOwner/currency}</ln_cur_code>
  <ln_amt>{$evo/outstanding/originalAmount}</ln_amt>
  <ln_liab_amt>{$evo/outstanding/currentAmount}</ln_liab_amt>
  <ln_maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $evo/eventOwner/maturityDate)}</ln_maturity_date>
  <pricing_option>{$evo/eventOwner/pricingOption}</pricing_option>
  <match_funding>{LIQ.XQ.IFTRUE($evo/eventOwner/getIsMatchFunded,'Y','N')}</match_funding>
  <rem_inst_description>{$evo/eventOwner/cashflowsClerk/borrowerAgentCashflow/remittanceInstruction/description}</rem_inst_description>
  <rem_inst_location_code>{$evo/eventOwner/cashflowsClerk/borrowerAgentCashflow/getLocation/locationCode}</rem_inst_location_code>
  <rem_inst_servicing_group_alias>{$evo/eventOwner/cashflowsClerk/borrowerAgentCashflow/servicingGroupAlias}</rem_inst_servicing_group_alias>
  <product_code>LN</product_code>
  <rate>{$evo/eventOwner/outstanding/rates/baseRate}</rate>
  <repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $evo/eventOwner/repricingDate)}</repricing_date>
  <repricing_frequency>{$evo/eventOwner/repricingFrequency}</repricing_frequency>
  <risk_type>{$evo/eventOwner/riskType}</risk_type>
  <status>{LIQ.XQ.IFTRUE($evo/outstanding/isActive,"ACTIVE","INACTIVE")}</status>
  <tnx_type_code>03</tnx_type_code>
  <prod_stat_code>08</prod_stat_code>
  <tnx_stat_code>04</tnx_stat_code>
  <tnx_amt>{$evo/eventOwner/actualAmount}</tnx_amt>
  <tnx_cur_code>{$evo/eventOwner/currency}</tnx_cur_code>
  {LIQ.XQ.UTIL.SET("accessCode","NULL")}
  {for $misCode in $evo/eventOwner/facility/misCodes[LIQ.XQS.EQUAL(@type,"PORTL")] return
		{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($misCode/valueType, "MIS Code", "description"))}
  }
  <ln_access_type>{$accessCode}</ln_access_type>
  <isSwingline>{LIQ.XQ.IFTRUE($evo/eventOwner/isSwingline,"Y", "N")}</isSwingline>
</ln_tnx_record>
};