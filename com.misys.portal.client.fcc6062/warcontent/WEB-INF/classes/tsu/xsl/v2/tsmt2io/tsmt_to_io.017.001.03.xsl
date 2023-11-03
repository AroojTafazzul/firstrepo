<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	exclude-result-prefixes="tools service">
	
	<xsl:output method ="xml"/>
	<xsl:param name="language">en</xsl:param>
	
	<xsl:include href="../tsmt_to_oa_common.xsl"/>
	<!-- Match template -->
	<xsl:template match="/">
	<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByTid(//RltdTxRefs/TxId)"/>
	<xsl:variable name="ioRefId" select="$messageDetails/tsu_message_details/link_ref_id"/>
	<xsl:variable name="references" select="service:manageReferences('IO', $ioRefId, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //ComrclDataSet/Buyr/Nm, //buyer_reference, //issuing_bank/abbv_name, '01')"/>
	
		<xsl:variable name="ref_id" select="$references/references/ref_id"/>
		<xsl:variable name="tnx_id" select="$references/references/tnx_id"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>

		<io_tnx_record>
			<brch_code>00001</brch_code>
			<product_code>IO</product_code>
			<company_id>
				<xsl:value-of select="$company_id"/>
			</company_id>
			<entity>
				<xsl:value-of select="$entity"/>
			</entity>
			<company_name>
				<xsl:value-of select="$company_name"/>
			</company_name>	
			
			<ref_id><xsl:value-of select="$ioRefId"/></ref_id>
			<tnx_id><xsl:value-of select="$tnx_id"/></tnx_id>
			<xsl:if test="//CreDtTm !=''">
				<iss_date>
					<xsl:value-of select="tools:convertISODateTime2MTPDateTime(//CreDtTm,$language)"/>
				</iss_date>
			</xsl:if>
			<xsl:if test="//TxId"> 
				<tid>
			   		<xsl:value-of select="//TxId"/>
			   	</tid>
		   	</xsl:if>
		   	<xsl:if test="//ComrclDocRef/InvcNb">
				<invoice_number>
					<xsl:value-of select="//ComrclDocRef/InvcNb" />
				</invoice_number>
			</xsl:if>
			<xsl:if test="//ComrclDocRef/IsseDt">
				<invoice_iss_date>
					<xsl:value-of select="//ComrclDocRef/IsseDt" />
				</invoice_iss_date>
			</xsl:if>
			<!-- Buyer Details -->
		   	<xsl:if test="//Buyr">
		   		<xsl:apply-templates select="//Buyr"/>
		   	</xsl:if>
		   	
		   	<!-- Seller Details -->
		   	<xsl:if test="//Sellr">
		   		<xsl:apply-templates select="//Sellr"/>
		   	</xsl:if>
		   	
	   		<!-- Bill To Details -->
		   	<xsl:if test="//BllTo">
		   		<xsl:apply-templates select="//BllTo"/>
		   	</xsl:if>

			<xsl:if test="//Goods/PurchsOrdrRef/Id !=''">
		   		<po_ref_id>
					<xsl:value-of select="//Goods/PurchsOrdrRef/Id"/>
				</po_ref_id>
		   	</xsl:if>
		   	
		   	<xsl:if test="//Goods/PurchsOrdrRef/DtOfIsse !=''">
				<po_issue_date>
					<xsl:value-of select="//Goods/PurchsOrdrRef/DtOfIsse"/>
				</po_issue_date>
			</xsl:if>
			
			<xsl:if test="//Goods/ComrclLineItms  != ''">
				<lineItems>
					<xsl:apply-templates select="//Goods/ComrclLineItms"/>
			   	</lineItems>
			</xsl:if>
			
			<xsl:if test="//Goods/LineItmsTtlAmt != ''">
				<total_amt>
					<xsl:value-of select="//Goods/LineItmsTtlAmt"/>
				</total_amt>
				<total_amt_cur_code>
					<xsl:value-of select="//Goods/LineItmsTtlAmt/@Ccy"/>
				</total_amt_cur_code>
			</xsl:if>
			
			<xsl:if test="//Goods/FrghtChrgs  != ''">
				<xsl:if test="//Goods/FrghtChrgs/Tp  != ''">
					<freight_charges_type>
						<xsl:value-of select="//Goods/FrghtChrgs/Tp"/>
					</freight_charges_type>
				</xsl:if>
				<xsl:if test="//Goods/FrghtChrgs/Chrgs">
					<freightCharges>
						<xsl:apply-templates select="//Goods/FrghtChrgs/Chrgs"/>
					</freightCharges>
				</xsl:if>
			</xsl:if>
			<xsl:if test="//Goods/Tax  != ''">
				<taxes>
					<xsl:apply-templates select="//Goods/Tax"/>
				</taxes>
			</xsl:if>
			<xsl:if test="//Goods/Incotrms  != ''">
			<incoterms>
				<xsl:apply-templates select="//Goods/Incotrms"/>
			</incoterms>
			</xsl:if>
			<xsl:if test="//Goods/Adjstmnt  != ''">
				<adjustments>
					<xsl:apply-templates select="//Goods/Adjstmnt"/>
		  		</adjustments>
		  	</xsl:if>
			<xsl:if test="//Goods/TtlNetAmt != ''">
				<total_net_amt>
					<xsl:value-of select="//Goods/TtlNetAmt"/>
				</total_net_amt>
				<total_net_cur_code>
					<xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/>
				</total_net_cur_code>
				<tnx_amt>
					<xsl:value-of select="//Goods/TtlNetAmt"/>
				</tnx_amt>
				<tnx_cur_code>
					<xsl:value-of select="//Goods/TtlNetAmt/@Ccy"/>
				</tnx_cur_code>
			</xsl:if>
			<xsl:if test="//Goods/LineItmsTtlAmt != ''">
				<total_amt>
					<xsl:value-of select="//Goods/LineItmsTtlAmt"/>
				</total_amt>
				<total_cur_code>
					<xsl:value-of select="//Goods/LineItmsTtlAmt/@Ccy"/>
				</total_cur_code>
			</xsl:if>
			<xsl:if test="//Goods/BuyrDfndInf  != ''">
			  <buyer_defined_informations>
			  		<xsl:apply-templates select="//Goods/BuyrDfndInf"/>
			  </buyer_defined_informations>
		  	</xsl:if>
		  <xsl:if test="//Goods/SellrDfndInf  != ''">
			  <seller_defined_informations>
			  		<xsl:apply-templates select="//Goods/SellrDfndInf"/>
			  </seller_defined_informations>
		  </xsl:if>  
  			<xsl:if test="//ComrclDataSet/PmtTerms  != ''">
	  			<xsl:choose>
		  			<xsl:when test="//ComrclDataSet/PmtTerms/Amt  != ''">
		  				<payment_terms_type>AMNT</payment_terms_type>
		  			</xsl:when>
		  			<xsl:otherwise>
		  				<payment_terms_type>PRCT</payment_terms_type>
		  			</xsl:otherwise>
	  			</xsl:choose>
				<payments>
				 	<xsl:apply-templates select="//ComrclDataSet/PmtTerms"/>
				</payments>
			</xsl:if>
			<xsl:if test="//ComrclDataSet/SttlmTerms != ''">
				<xsl:apply-templates select="//ComrclDataSet/SttlmTerms"/>			
			</xsl:if>

			<xsl:if test="//TrnsprtDataSet != ''">
				<payment_transport_dataset>
    				<xsl:apply-templates select="//TrnsprtDataSet"/>
				</payment_transport_dataset>
			</xsl:if>
			
			<xsl:if test="//InsrncDataSet != ''">
				<payment_insurance_dataset>
    				<xsl:apply-templates select="//InsrncDataSet"/>
				</payment_insurance_dataset>
			</xsl:if>
			<xsl:if test="//CertDataSet != ''">
				<payment_certificate_dataset>
    				<xsl:apply-templates select="//CertDataSet"/>
				</payment_certificate_dataset>
			</xsl:if>
			<xsl:if test="//OthrCertDataSet != ''">
				<payment_other_certificate_dataset>
    				<xsl:apply-templates select="//OthrCertDataSet"/>
				</payment_other_certificate_dataset>
			</xsl:if>
		</io_tnx_record>
	</xsl:template>
</xsl:stylesheet>
