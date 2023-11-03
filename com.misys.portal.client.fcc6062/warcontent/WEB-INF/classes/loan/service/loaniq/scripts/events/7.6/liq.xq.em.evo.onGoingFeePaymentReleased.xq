declare function liq.xq.em.evo.onGoingFeePaymentReleased($evo){
<ft_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.misys.com/mtp/interfaces/xsd/ln.xsd">
	<bo_ref_id>{$evo/eventOwner/id}</bo_ref_id>
	<bo_tnx_id>{$evo/eventOwner/id}</bo_tnx_id>
	<bo_deal_id>{$evo/eventOwner/dealId}</bo_deal_id>
	<bo_deal_name>{$evo/eventOwner/dealName}</bo_deal_name>
	<bo_facility_id>{$evo/eventOwner/facilityId}</bo_facility_id>
	<bo_facility_name>{$evo/eventOwner/facilityName}</bo_facility_name>
	<applicant_reference>{$evo/eventOwner/getBorrower/externalId}</applicant_reference>
	<effective_date>{LIQ.XQ.FORMAT_DATE("%d/%m/%Y", $evo/eventOwner/effectiveDate)}</effective_date>
	<product_code>FT</product_code>
	<sub_product_code>LNFP</sub_product_code>
	<tnx_type_code>01</tnx_type_code>
	<sub_tnx_type_code>B3</sub_tnx_type_code>
	<prod_stat_code>04</prod_stat_code>
	<tnx_stat_code>04</tnx_stat_code>
	<tnx_cur_code>{$evo/eventOwner/currency}</tnx_cur_code>
	<tnx_amt>{$evo/eventOwner/requestedAmountDisplay}</tnx_amt>
	<fee_amt>{$evo/eventOwner/requestedAmountDisplay}</fee_amt>
	<fee_cur_code>{$evo/eventOwner/currency}</fee_cur_code>
	<ft_amt>{$evo/eventOwner/requestedAmountDisplay}</ft_amt>
	<ft_cur_code>{$evo/eventOwner/currency}</ft_cur_code>
	<fee_description>{$evo/eventOwner/getFeeName}</fee_description>
	<fee_type>{$evo/eventOwner/getFeeType}</fee_type>
	<fee_cycle_start_date>{$evo/eventOwner/cycleStartDate}</fee_cycle_start_date>
	<fee_cycle_due_date>{$evo/eventOwner/cycleDueDate}</fee_cycle_due_date>
	<fee_cycle_id>{$evo/eventOwner/getAccrualCycle/cycleNumber}</fee_cycle_id>
	<fee_cycle_end_date>{$evo/eventOwner/cycleEndDate}</fee_cycle_end_date>
	<cycle_due_amt>{$evo/eventOwner/currentCycleDue}</cycle_due_amt>
	<cycle_paid_amt>{$evo/eventOwner/paidSoFar}</cycle_paid_amt>
</ft_tnx_record>
};
