declare function getRepricingDetailsByIds($rids){
	<liqInfo>
		<loanRepricing>
    		 {for $loanRepricingId in LIQ.XQ.UTIL.TOKENIZE($rids," ") return
     			{for $d in $loanRepricingId[LIQ.BO.ISFALSE(LIQ.XQS.EQUAL($loanRepricingId,''))] return
				{getDetailsOfLoanRepricing($loanRepricingId)}
			}
    	 	}
		</loanRepricing>
	</liqInfo>
};