declare function getDetailsOfLoanRepricing($loanRepricingId){
{LIQ.XQ.UTIL.SET("LoanRepricing", LIQ.BO.GetBOByRID("LoanRepricing",$loanRepricingId))}
<bk_tnx_record
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://www.misys.com/mtp/interfaces/xsd/ln.xsd">
    <bo_tnx_id>{$LoanRepricing/id}</bo_tnx_id>  
    <bo_ref_id>{$LoanRepricing/id}</bo_ref_id>
	<product_code>BK</product_code>
	<sub_product_code>LNRPN</sub_product_code>		
    <tnx_type_code>01</tnx_type_code>	
  	<prod_stat_code>03</prod_stat_code>
  	<tnx_stat_code>04</tnx_stat_code>
    {for $borr in $LoanRepricing/borrowers return
    <applicant_reference>{$borr/externalId}</applicant_reference>
    <borrower_reference>{$borr/externalId}</borrower_reference>
    {LIQ.XQ.UTIL.SET("repricing",$LoanRepricing)}
    <child_product_code>LN</child_product_code>
	<child_sub_product_code>BKLN</child_sub_product_code>
	<bk_type>RPLN</bk_type>
	<tnx_amt>{$repricing/getNewOutstandings}</tnx_amt>
	<bk_total_amt>{$repricing/getNewOutstandings}</bk_total_amt>
	<principal_payment>{LIQ.XQ.IFTRUE($repricing/hasPrincipalPayments,'Y','N')}</principal_payment>
	<total_principal_amt>{$repricing/getPaymentAmount}</total_principal_amt>
	<borrower_settlement_ind>{LIQ.XQ.IFTRUE($repricing/getNetForBorrowerIndicator,'Y','N')}</borrower_settlement_ind>
	<bk_cur_code>{$repricing/getCurrency}</bk_cur_code>
	<tnx_cur_code>{$repricing/getCurrency}</tnx_cur_code>
	{LIQ.XQ.UTIL.SET("interestPayment",LIQ.XQ.IFTRUE($repricing/includesInterestPayment,'Y','N'))}
	{LIQ.XQ.UTIL.SET("interestPayment",LIQ.XQ.IFTRUE($repricing/hasScheduledInterestPayments,$repricing/hasScheduledInterestPayments,$repricing/includesInterestPayment))}
	<interest_payment>{LIQ.XQ.IFTRUE($interestPayment,'Y','N')}</interest_payment>
	<deal_name>{$repricing/getDealName}</deal_name>
	<sub_tnx_type_code>97</sub_tnx_type_code>
    }

	<interestPayments>
		 	{for $interestPayment in $repricing/interestPayments return
				<interestPayment>
		    		<loanAlias>{$interestPayment/getLoanAlias}</loanAlias>
		        	<interesteDueAmt>{$interestPayment/getRequestedAmount}</interesteDueAmt>
		        	<cycleStartDate>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y",$interestPayment/getCycleStartDate)}</cycleStartDate>
				</interestPayment>
			}
	</interestPayments>	
		 
<repricing_new_loans>
{for $nl in $LoanRepricing/outgoingOutstandings return
<ln_tnx_record>
	<bo_ref_id>{$nl/alias}</bo_ref_id>
	<bo_tnx_id>{$LoanRepricing/id}</bo_tnx_id>
	<bo_ref_alias>{$nl/alias}</bo_ref_alias>
  	<bo_deal_id>{$nl/dealId}</bo_deal_id>
  	<bo_deal_name>{$nl/dealName}</bo_deal_name>
  	<bo_facility_id>{$nl/facilityId}</bo_facility_id>
  	<bo_facility_name>{$nl/facilityName}</bo_facility_name>
  	<borrower_reference>{LIQ.BO.GetBOByRID("Customer", $nl/borrowerId)/externalId}</borrower_reference>
  	<effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $nl/effectiveDate)}</effective_date>
  	<ln_liab_amt>{$nl/currentAmount}</ln_liab_amt>
  	<ln_amt>{$nl/originalAmount}</ln_amt>
  	<ln_cur_code>{$nl/currency}</ln_cur_code>
  	<ln_maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $nl/maturityDate)}</ln_maturity_date>
  	<pricing_option>{$nl/pricingOption}</pricing_option>
  	<product_code>LN</product_code>
  	<rate>{$nl/rates/baseRate}</rate>
  	<match_funding>{LIQ.XQ.IFTRUE($nl/getIsMatchFunded,'Y','N')}</match_funding>
	<repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $nl/repricingDate)}</repricing_date>
  	<repricing_frequency>{$nl/repricingFrequency}</repricing_frequency>
  	<risk_type>{$nl/riskType}</risk_type>
  	<tnx_amt>{$nl/originalAmount}</tnx_amt>
  	<tnx_cur_code>{$nl/currency}</tnx_cur_code>
  	<tnx_type_code>01</tnx_type_code>
	<sub_tnx_type_code>97</sub_tnx_type_code>
  	<prod_stat_code>03</prod_stat_code>
  	<tnx_stat_code>04</tnx_stat_code>
    <status>{LIQ.XQ.IFTRUE($nl/isActive,"ACTIVE","INACTIVE")}</status>
	<fxRate>{$nl/getFacilityFxExchange/getDisplayRate}</fxRate>
		<fac_cur_code>{$nl/getFacilityCurrency}</fac_cur_code>
	{LIQ.XQ.UTIL.SET("accessCode","NULL")}
	{for $misCode in $nl/facility/misCodes[LIQ.XQS.EQUAL(@type,"PORTL")] return
			{LIQ.XQ.UTIL.SET("accessCode",LIQ.BO.GetCodeTableEntry($misCode/valueType, "MIS Code", "description"))}
	}
	<ln_access_type>{$accessCode}</ln_access_type>
	
  </ln_tnx_record>
}
</repricing_new_loans>
<oldLoans>
{for $ol in $LoanRepricing/incomingLoans return
	<oldLoan>
		<bo_ref_id>{$ol/alias}</bo_ref_id>
		<bo_tnx_id>{$LoanRepricing/id}</bo_tnx_id>
		<bo_ref_alias>{$ol/alias}</bo_ref_alias>
		<bo_deal_id>{$ol/dealId}</bo_deal_id>
  		<bo_deal_name>{$ol/dealName}</bo_deal_name>
		<bo_facility_id>{$ol/facilityId}</bo_facility_id>
  		<bo_facility_name>{$ol/facilityName}</bo_facility_name>
		<borrower_reference>{LIQ.BO.GetBOByRID("Customer", $ol/borrowerId)/externalId}</borrower_reference>
		<effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $ol/effectiveDate)}</effective_date>
		<ln_liab_amt>{$ol/currentAmount}</ln_liab_amt>
  		<ln_amt>{$ol/originalAmount}</ln_amt>
 		<ln_cur_code>{$ol/currency}</ln_cur_code>
	 	<ln_maturity_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $ol/maturityDate)}</ln_maturity_date>
		<pricing_option>{$ol/pricingOption}</pricing_option>
		<product_code>LN</product_code>
		<rate>{$ol/rates/baseRate}</rate>
		<match_funding>{LIQ.XQ.IFTRUE($ol/getIsMatchFunded,'Y','N')}</match_funding>
		<repricing_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $ol/repricingDate)}</repricing_date>
		<repricing_frequency>{$ol/repricingFrequency}</repricing_frequency>
  		<risk_type>{$ol/riskType}</risk_type>
		<tnx_amt>{$ol/originalAmount}</tnx_amt>
  		<tnx_cur_code>{$ol/currency}</tnx_cur_code>
  		<tnx_type_code>58</tnx_type_code>
  		<prod_stat_code>77</prod_stat_code>
  		<tnx_stat_code>04</tnx_stat_code>    
		<ln_status>{$ol/statusLabel}</ln_status>
        <status>{LIQ.XQ.IFTRUE($ol/isActive,"ACTIVE","INACTIVE")}</status>
        <under_repricing>N</under_repricing>
        
	</oldLoan>
}
</oldLoans>
</bk_tnx_record>
};