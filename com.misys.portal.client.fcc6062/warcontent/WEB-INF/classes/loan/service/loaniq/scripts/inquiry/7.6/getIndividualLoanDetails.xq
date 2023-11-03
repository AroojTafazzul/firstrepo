declare function getIndividualLoanDetails($loanId){
{LIQ.XQ.UTIL.SET("outstanding", LIQ.BO.GetBOByRID("Outstanding",$loanId))}
<ln_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.misys.com/mtp/interfaces/xsd/ln.xsd">
<bo_ref_id>{$outstanding/alias}</bo_ref_id>
 <status>{LIQ.XQ.IFTRUE($outstanding/isActive,"ACTIVE","INACTIVE")}</status>
 <bo_tnx_id>{$outstanding/id}</bo_tnx_id>
 <bo_deal_id>{$outstanding/dealId}</bo_deal_id>
 <bo_deal_name>{$outstanding/dealName}</bo_deal_name>
 <bo_facility_id>{$outstanding/facilityId}</bo_facility_id>
 <bo_facility_name>{$outstanding/facilityName}</bo_facility_name>
 <borrower_reference>{LIQ.BO.GetBOByRID("Customer", $outstanding/borrowerId)/externalId}</borrower_reference>
 <effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $outstanding/effectiveDate)}</effective_date>
 <ln_liab_amt>{$outstanding/currentAmount}</ln_liab_amt>
 <ln_amt>{$outstanding/originalAmount}</ln_amt>
 <ln_cur_code>{$outstanding/currency}</ln_cur_code>
 <ln_maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $outstanding/maturityDate)}</ln_maturity_date>
 <pricing_option>{$outstanding/pricingOption}</pricing_option>
 <product_code>LN</product_code>
 <rate>{$outstanding/outstanding/rates/baseRate}</rate>
 <match_funding>{LIQ.XQ.IFTRUE($outstanding/getIsMatchFunded,'Y','N')}</match_funding>  
 <repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $outstanding/repricingDate)}</repricing_date>
 <repricing_frequency>{$outstanding/repricingFrequency}</repricing_frequency>
 <risk_type>{$outstanding/riskType}</risk_type>
 {LIQ.XQ.UTIL.SET("outStandingID", $outstanding/id)}
 {for $otrD in /OutstandingTransaction[LIQ.XQS.EQUAL(@type,"RCMF")][LIQ.XQS.EQUAL(@outstandingId,$outStandingID)] return
 <loan_repricing_trans_rid>{$otrD/otr/getGroupId}</loan_repricing_trans_rid>
  <rem_inst_description>{$otrD/otr/cashflowsClerk/borrowerAgentCashflow/remittanceInstruction/description}</rem_inst_description>
  <rem_inst_location_code>{$otrD/otr/cashflowsClerk/borrowerAgentCashflow/getLocation/locationCode}</rem_inst_location_code>
  <rem_inst_servicing_group_alias>{$otrD/otr/cashflowsClerk/borrowerAgentCashflow/servicingGroupAlias}</rem_inst_servicing_group_alias>
  <fxRate>{$otrD/otr/outstanding/getFacilityFxExchange/getDisplayRate}</fxRate>
 }
 {for $otrD in /OutstandingTransaction[LIQ.XQS.EQUAL(@type,"ID")][LIQ.XQS.EQUAL(@outstandingId,$outStandingID)] return
 <drawdown_rrid>{$otrD/otr/id}</drawdown_rrid>
 <rem_inst_description>{$otrD/otr/cashflowsClerk/borrowerAgentCashflow/remittanceInstruction/description}</rem_inst_description>
 <rem_inst_location_code>{$otrD/otr/cashflowsClerk/borrowerAgentCashflow/getLocation/locationCode}</rem_inst_location_code>
 <rem_inst_servicing_group_alias>{$otrD/otr/cashflowsClerk/borrowerAgentCashflow/servicingGroupAlias}</rem_inst_servicing_group_alias>
 <fxRate>{$otrD/otr/outstanding/getFacilityFxExchange/getDisplayRate}</fxRate>
 }
 <fac_cur_code>{$outstanding/getFacilityCurrency}</fac_cur_code>
 <is_auto_rollover_enabled>{LIQ.XQ.IFTRUE(LIQ.XQ.UTIL.GET_AUTOGEN_FOR_OUTSTANDING($outstanding/id,"COMPR"), "Y","N")}</is_auto_rollover_enabled>
 <tnx_amt>{$outstanding/originalAmount}</tnx_amt>
 <tnx_cur_code>{$outstanding/currency}</tnx_cur_code>
 {LIQ.XQ.UTIL.SET("accessCode","NULL")}
 {for $misCode in $outstanding/facility/misCodes[LIQ.XQS.EQUAL(@type,"PORTL")] return
	{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($misCode/valueType, "MIS Code", "description"))}
 }
 <ln_access_type>{$accessCode}</ln_access_type>
 <isSwingline>{LIQ.XQ.IFTRUE($outstanding/isSwingline,"Y", "N")}</isSwingline>
 <tnx_type_code>62</tnx_type_code>
 <prod_stat_code>07</prod_stat_code>
 <tnx_stat_code>04</tnx_stat_code>
</ln_tnx_record>
};