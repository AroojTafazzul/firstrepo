declare function liq.xq.em.evo.loanRename($evo){

<liqInfo>
<alias_change_details>
                <new_alias>{$evo/eventOwner/alias}</new_alias>
		{for $ev in $evo/eventOwner/eventsInReverseOrder[LIQ.BO.ContainsCode(@actionCode,"RENME")] return              
                <old_alias>{$ev/eventCommentMLE}</old_alias>}
</alias_change_details>
</liqInfo>
};
