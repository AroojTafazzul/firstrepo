declare function liq.xq.em.evo.paperClipReleased($drawdown){
<ln_tnx_record
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://www.misys.com/mtp/interfaces/xsd/ln.xsd">
		<bo_tnx_id>{$drawdown/eventOwner/id}</bo_tnx_id>
  <borrower_reference>{$drawdown/eventOwner/getBorrower/externalId}</borrower_reference>
  <effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $drawdown/eventOwner/effectiveDate)}</effective_date>
  <match_funding>{LIQ.XQ.IFTRUE($drawdown/eventOwner/getIsMatchFunded,'Y','N')}</match_funding>
  <product_code>LN</product_code>
  <status>{LIQ.XQ.IFTRUE($drawdown/outstanding/isActive,"ACTIVE","INACTIVE")}</status>
  <tnx_type_code>13</tnx_type_code>
  <sub_tnx_type_code>16</sub_tnx_type_code>
  <prod_stat_code>01</prod_stat_code>
  <tnx_stat_code>04</tnx_stat_code>
  <isSwingline>{LIQ.XQ.IFTRUE($drawdown/eventOwner/isSwingline,"Y", "N")}</isSwingline>
  {LIQ.XQ.UTIL.SET("rid",$drawdown/eventOwner/id)}
	{for $tran in LIQ.BO.GetBOByRID("PaperClipTransaction", $rid)
	  return
		{for $o in $tran/sortedTransactions[LIQ.BO.ContainsCode(@type,"PPYMT")] return
 <bo_ref_id>{$o/alias}</bo_ref_id>
		 <principal_payment>
  {LIQ.XQ.UTIL.SET("accessCode","NULL")}
  {for $misCode in $o/getFacility/misCodes[LIQ.XQS.EQUAL(@type,"PORTL")] return
		{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($misCode/valueType, "MIS Code", "description"))}
  }
  			
			<bo_deal_id>{$o/dealId}</bo_deal_id>
		    <bo_deal_name>{$o/dealName}</bo_deal_name>
  			<bo_facility_id>{$o/facilityId}</bo_facility_id>
		    <bo_facility_name>{$o/facilityName}</bo_facility_name>
			<ln_maturity_date>{$o/getMaturityDate}</ln_maturity_date>
			
			<bo_tnx_id>{$o/id}</bo_tnx_id>
			<status>{$o/status}</status>
			<pricing_option>{$o/pricingOption}</pricing_option>
			<risk_type>{$o/riskType}</risk_type>
			<type>Principal</type>
			<ln_amt>{$o/paperClipApplicableAmount}</ln_amt>
			<tnx_amt>{$o/paperClipApplicableAmount}</tnx_amt>
			<tnx_cur_code>{$o/currency}</tnx_cur_code>
			<ln_liab_amt>{$o/loanCurrentAmount}</ln_liab_amt>
			<ln_cur_code>{$o/currency}</ln_cur_code>
			<repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $o/repricingDate)}</repricing_date>
			<repricing_frequency>{$o/repricingFrequency}</repricing_frequency>
		 </principal_payment>
		} 
     {for $o in $tran/sortedTransactions[LIQ.BO.ContainsCode(@type,"OPMT")] return 
	<bo_ref_id>{$o/alias}</bo_ref_id>
		 <interest_payment>
			{LIQ.XQ.UTIL.SET("accessCode","NULL")}
  {for $misCode in $o/getFacility/misCodes[LIQ.XQS.EQUAL(@type,"PORTL")] return
		{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($misCode/valueType, "MIS Code", "description"))}
  }
  			<ln_access_type>{$accessCode}</ln_access_type> 																			   
			<bo_deal_id>{$o/dealId}</bo_deal_id>
		    <bo_deal_name>{$o/dealName}</bo_deal_name>
  			<bo_facility_id>{$o/facilityId}</bo_facility_id>
		    <bo_facility_name>{$o/facilityName}</bo_facility_name>
			<ln_maturity_date>{$o/getMaturityDate}</ln_maturity_date>												
			<bo_tnx_id>{$o/id}</bo_tnx_id>
			<status>{$o/status}</status>
			<pricing_option>{$o/pricingOption}</pricing_option>
			<type>Interest</type>
			<risk_type>{$o/riskType}</risk_type>
			<type>Principal</type>			 
			<ln_amt>{$o/paperClipApplicableAmount}</ln_amt>
			<tnx_amt>{$o/paperClipApplicableAmount}</tnx_amt>
			<tnx_cur_code>{$o/currency}</tnx_cur_code>
			<ln_liab_amt>{$o/loanCurrentAmount}</ln_liab_amt>										
			<ln_cur_code>{$o/currency}</ln_cur_code>
			<repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $o/repricingDate)}</repricing_date>
			<repricing_frequency>{$o/repricingFrequency}</repricing_frequency>
		 </interest_payment>
		}
	}
</ln_tnx_record>
};
