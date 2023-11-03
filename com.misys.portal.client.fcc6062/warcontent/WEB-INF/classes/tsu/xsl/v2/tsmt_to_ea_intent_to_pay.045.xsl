<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:tnxidgenerator="xalan://com.misys.portal.product.util.generator.TransactionIdGenerator"
	xmlns:refidgenerator="xalan://com.misys.portal.product.util.generator.ReferenceIdGenerator"
	exclude-result-prefixes="tools tnxidgenerator refidgenerator">
	
	<xsl:output method ="xml"/>

	<xsl:param name="language">en</xsl:param>
	<xsl:param name="brnchCode">00001</xsl:param>
	
	<!-- Match template -->
	<xsl:template match="/">
		<ea_tnx_record>
			<brch_code>
				<xsl:value-of select="$brnchCode"/>
			</brch_code>
			<xsl:choose>
				<xsl:when test= "//InttToPay/ByPurchsOrdr">
					<po_ref_id>
						<xsl:value-of select="//InttToPay/ByPurchsOrdr/Id"/>
					</po_ref_id>
					<po_issue_date>
						<xsl:value-of select="//InttToPay/ByPurchsOrdr/DtOfIsse"/>
					</po_issue_date>
					<adjustments>
					<xsl:for-each select="//InttToPay/ByPurchsOrdr/Adjstmnt">
						<adjustment>
							<type>
								<xsl:value-of select="Tp"/>
							</type>
							<other_type>
								<xsl:value-of select="OthrAdjstmntTp"/>
							</other_type>
							<direction>
								<xsl:value-of select="Drctn"/>
							</direction>
							<cur_code>
								<xsl:value-of select="Amt/@Ccy"/>
							</cur_code>
							<amt>
								<xsl:value-of select="Amt"/>
							</amt>
							<is_valid>Y</is_valid>
						</adjustment>
					</xsl:for-each>
	  			</adjustments>
	  			<intent_to_pay_amt>
					<xsl:value-of select="//InttToPay/ByPurchsOrdr/NetAmt"/>
				</intent_to_pay_amt>
				<tnx_cur_code>
					<xsl:value-of select="//InttToPay/ByPurchsOrdr/NetAmt/@Ccy"/>
				</tnx_cur_code>
				</xsl:when>
				<xsl:otherwise>
					<invoice_number>
						<xsl:value-of select="//InttToPay/ByComrclInvc/ComrclDocRef/InvcNb"/>
					</invoice_number>
					<invoice_iss_date>
						<xsl:value-of select="//InttToPay/ByComrclInvc/ComrclDocRef/IsseDt"/>
					</invoice_iss_date>
					<adjustments>
					<xsl:for-each select="//InttToPay/ByComrclInvc/Adjstmnt">
						<adjustment>
							<brch_code>
								<xsl:value-of select="$brnchCode"/>
							</brch_code>
							<type>
								<xsl:value-of select="Tp"/>
							</type>
							<other_type>
								<xsl:value-of select="OthrAdjstmntTp"/>
							</other_type>
							<direction>
								<xsl:value-of select="Drctn"/>
							</direction>
							<cur_code>
								<xsl:value-of select="Amt/@Ccy"/>
							</cur_code>
							<amt>
								<xsl:value-of select="Amt"/>
							</amt>
							<is_valid>Y</is_valid>
						</adjustment>
					</xsl:for-each>
	  			</adjustments>
				<intent_to_pay_amt>
					<xsl:value-of select="//InttToPay/ByComrclInvc/NetAmt"/>
				</intent_to_pay_amt>
				
				
				
					
				</xsl:otherwise>
			</xsl:choose>
			
			<expected_payment_date>
				<xsl:value-of select="//InttToPay/XpctdPmtDt"/>
			</expected_payment_date>
			<xsl:if test="//InttToPay/SttlmTerms">
				<fin_inst_bic><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/BIC"/></fin_inst_bic>								
				<fin_inst_name><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/NmAndAdr/Nm"/></fin_inst_name>
				<fin_inst_street_name><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm"/></fin_inst_street_name>
				<fin_inst_post_code><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId"/></fin_inst_post_code>
				<fin_inst_town_name><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm"/></fin_inst_town_name>
				<fin_inst_country_sub_div><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn"/></fin_inst_country_sub_div>
				<fin_inst_country><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry"/></fin_inst_country>
				
				<seller_account_id><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Id/Othr"/></seller_account_id>
				<seller_account_upic><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Id/UPIC"/></seller_account_upic>
				<seller_account_bban><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Id/BBAN"/></seller_account_bban>
				<seller_account_iban><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Id/IBAN"/></seller_account_iban>
				<seller_account_type_code><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Tp/Cd"/></seller_account_type_code>			
				<seller_account_cur_code><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Ccy"/></seller_account_cur_code>
				<seller_account_name><xsl:value-of select="//InttToPay/SttlmTerms/CdtrAcct/Nm"/></seller_account_name>
			</xsl:if>
			
			<xsl:if test = "//ReqForActn">
				<request_for_action_type>
					<xsl:value-of select="//ReqForActn/Tp"/>
				</request_for_action_type>
				<request_for_action_desc>
					<xsl:value-of select="//ReqForActn/Desc"/>
				</request_for_action_desc>		
			</xsl:if>			
		</ea_tnx_record>
	</xsl:template>
</xsl:stylesheet>
