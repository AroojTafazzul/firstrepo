<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
  exclude-result-prefixes="tools">

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:param name="tid"/>
<xsl:param name="messageId"/>
<xsl:param name="paymentAmt"/>
<xsl:param name="paymentDueDt"/>

<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>

<!-- Main template -->
<xsl:template match="io_tnx_record">

  <Document>
  <InttToPayNtfctn>
    <NtfctnId>
      <Id><xsl:value-of select="$tid"/></Id>
      <CreDtTm><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></CreDtTm>
    </NtfctnId>
    <TxId><Id><xsl:value-of select="$tid"/></Id></TxId>
	<!-- <SubmitrTxRef/>-->
    <BuyrBk>
		<BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
	</BuyrBk>
	<!-- Seller bank- ? from where the value need to get -->
	<SellrBk>
		<BIC><xsl:value-of select="seller_bank_bic"/></BIC>
	</SellrBk>
    <InttToPay>
    	
    	<!-- MPSSC-9053 use the intent to pay section with the ‘by Commercial Invoice’ option therefore disabled
    		
    		<ByPurchsOrdr>
    			<PurchsOrdrRef>
    				<Id><xsl:value-of select="po_ref_id"/></Id>
    				<DtOfIsse><xsl:value-of select="po_issue_date"/></DtOfIsse>
    			</PurchsOrdrRef>
    			 <Adjstmnt>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrAdjstmntTp><xsl:value-of select="other_type"/></OthrAdjstmntTp>
		      </xsl:otherwise>
		      </xsl:choose>	
		      <Drctn><xsl:value-of select="direction"/>
		      </Drctn>
		      <Amt>
		      <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="tools:convertMTPAmount2TSUAmount(amt)"/>
		        </Amt>
		      </Adjstmnt>
    			<NetAmt><xsl:value-of select="payment_amt"/></NetAmt>
    			<BrkdwnByPurchsOrdr>
    				<TxId><xsl:value-of select="$tid"/></TxId>
    				<PurchsOrdrRef>
    					<Id><xsl:value-of select="po_ref_id"/></Id>
    					<DtOfIsse><xsl:value-of select="po_issue_date"/></DtOfIsse>
    				</PurchsOrdrRef>
    			</BrkdwnByPurchsOrdr>
    		</ByPurchsOrdr> -->
    		
    	<ByComrclInvc>
   		  <ComrclDocRef>
   		  	<InvcNb><xsl:value-of select="invoice_number"/></InvcNb>
   		  	<IsseDt><xsl:value-of select="tools:getCurrentTMAFormatDate(invoice_iss_date,'')"/></IsseDt>
   		  </ComrclDocRef>    		  
			<xsl:if test="adjustments/adjustment">
				<xsl:apply-templates select="adjustments/adjustment" />
			</xsl:if> 		   
			<NetAmt>
				<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code" /></xsl:attribute>
				<xsl:value-of select="$paymentAmt"/>
			</NetAmt>
			<BrkdwnByPurchsOrdr>
				<TxId>
					<xsl:value-of select="$tid"/>
				</TxId>
				<PurchsOrdrRef>
    				<Id><xsl:value-of select="po_ref_id"/></Id>
    				<DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDate(po_issue_date,'')"/></DtOfIsse>
    			</PurchsOrdrRef>
    			<xsl:if test="adjustments/adjustment">
					<xsl:apply-templates select="adjustments/adjustment" />
				</xsl:if>
				<NetAmt>
					<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code" /></xsl:attribute>
					<xsl:value-of select="$paymentAmt"/>
				</NetAmt>
			</BrkdwnByPurchsOrdr>
    	
    	</ByComrclInvc>    	
      <XpctdPmtDt><xsl:value-of select="tools:getCurrentTMAFormatDate($paymentDueDt,'')"/></XpctdPmtDt>
      <SttlmTerms>
      	 <CdtrAgt>
      	 	<xsl:choose>
      	 		<xsl:when test = "fin_inst_bic != ''">
      	 		 	<BIC><xsl:value-of select="fin_inst_bic"/></BIC>
      	 		</xsl:when>
      	 		<xsl:otherwise>
	      	 		<NmAndAdr>
	      	 			<Nm><xsl:value-of select="fin_inst_name"/></Nm>
	      	 			<Adr>
	      	 				<xsl:if test = "fin_inst_street_name != ''">
	      	 					<StrtNm><xsl:value-of select="fin_inst_street_name"/></StrtNm>
	      	 				</xsl:if>
	      	 				<PstCdId><xsl:value-of select="fin_inst_post_code"/></PstCdId>
	      	 				<TwnNm><xsl:value-of select="fin_inst_town_name"/></TwnNm>
	      	 				<xsl:if test = "fin_inst_country_sub_div != ''">
	      	 					<CtrySubDvsn><xsl:value-of select="fin_inst_country_sub_div"/></CtrySubDvsn>
	      	 				</xsl:if>	      	 				
	      	 				<Ctry><xsl:value-of select="fin_inst_country"/></Ctry>
	      	 			</Adr>
      	 			</NmAndAdr>
      	 		</xsl:otherwise>
      	 	</xsl:choose>      	 	
      	 </CdtrAgt>
      	 <CdtrAcct>
      	 	<Id>
	      	 	<xsl:if test = "seller_account_iban != ''">
	      	 		<IBAN><xsl:value-of select="seller_account_iban"/></IBAN>
	      	 	</xsl:if>
	      	 	<xsl:if test = "seller_account_bban != ''">
	      	 		<BBAN><xsl:value-of select="seller_account_bban"/></BBAN>
	      	 	</xsl:if>
	      	 	<xsl:if test = "seller_account_upic != ''">
	      	 		<UPIC><xsl:value-of select="seller_account_upic"/></UPIC>
	      	 	</xsl:if>
	      	 	<xsl:if test = "seller_account_id != ''">
	      	 		<PrtryAcct>
	      	 			<Id><xsl:value-of select="seller_account_id"/></Id>
	      	 		</PrtryAcct>
	      	 	</xsl:if>     	 		
      	 	</Id>
      	 	<xsl:if test = "seller_account_type_code != '' or seller_account_type_prop != ''">
      	 		<Tp>
      	 			<xsl:if test = "seller_account_type_code != ''">
      	 				<Cd><xsl:value-of select="seller_account_type_code"/></Cd>
      	 			</xsl:if>
      	 			<xsl:if test = "seller_account_type_prop != ''">
      	 				<Prtry><xsl:value-of select="seller_account_type_prop"/></Prtry>
      	 			</xsl:if>
      	 		</Tp>     	 	
      	 	</xsl:if>
      	 	<xsl:if test ="seller_account_cur_code != ''">
      	 		<Ccy><xsl:value-of select="seller_account_cur_code"/></Ccy>
      	 	</xsl:if> 
      	 	<xsl:if test ="seller_account_name != ''">
      	 		<Nm><xsl:value-of select="seller_account_name"/></Nm>
      	 	</xsl:if> 
      	 
      	 </CdtrAcct>     
      </SttlmTerms>
    </InttToPay>
  </InttToPayNtfctn>
  </Document>

</xsl:template>

<xsl:template match="adjustments/adjustment">
	  <Adjstmnt>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrAdjstmntTp><xsl:value-of select="other_type"/></OthrAdjstmntTp>
		      </xsl:otherwise>
		    </xsl:choose>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	 	   <Drctn><xsl:value-of select="direction"/></Drctn>
	  </Adjstmnt>
	</xsl:template>

</xsl:stylesheet>