declare function liq.xq.em.evo.dealRename($evo){
	<liqInfo>
<deal_change_details>
     <deal_id>{$evo/eventOwner/id}</deal_id>
     <deal_name>{$evo/eventOwner/dealName}</deal_name>
</deal_change_details>
	</liqInfo>
};
