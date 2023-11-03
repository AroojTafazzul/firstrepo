declare function getLoanHistoryByIds($rids){
	<liqInfo>
		<loans>
    		 {for $loanId1 in LIQ.XQ.UTIL.TOKENIZE($rids," ") return
     			{for $d in $loanId1[LIQ.BO.ISFALSE(LIQ.XQS.EQUAL($loanId1,''))] return
				{getIndividualLoanDetails($loanId1)}
			}
    	 	}
		</loans>
	</liqInfo>
};