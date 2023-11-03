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
	<xsl:variable name="bankDetailsFromSellerBic" select="tools:retrieveBankDetailsFromBICCode(//PushdThrghBaseln/SellrBk/BIC,//Sellr/Nm)" />
		<xsl:variable name="messageDetails" select="tools:getTSUMessageDetailsByTid(//TxId/Id)"/>
		<xsl:variable name="eaRefId">
			<xsl:value-of select="$messageDetails/tsu_message_details/link_ref_id"/>
		</xsl:variable>
		<xsl:variable name="references" select="service:manageReferences('EA', $eaRefId, //tnx_id, //bo_ref_id, //cust_ref_id, //company_id, //PushdThrghBaseln/Sellr/Nm, //seller_reference, //issuing_bank/abbv_name, '01')"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="company_name" select="$references/references/company_name"/>
		<xsl:variable name="entity" select="$references/references/entity"/>
		<ea_tnx_record>
			<ref_id>
				<xsl:value-of select="$eaRefId"/>
			</ref_id>
			<tnx_id>
				<xsl:value-of select ="$references/references/tnx_id"/>
			</tnx_id>
			<brch_code>00001</brch_code>
			<company_id>
				<xsl:value-of select="$company_id"/>
			</company_id>
			<entity>
				<xsl:value-of select="$entity"/>
			</entity>
			<company_name>
				<xsl:value-of select="$company_name"/>
			</company_name>	
			<issuing_bank_abbv_name><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_abbv_name"/></issuing_bank_abbv_name>
			<issuing_bank_name><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_name"/></issuing_bank_name>
			<issuing_bank_address_line_1><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_addr_line_1"/></issuing_bank_address_line_1>
			<issuing_bank_address_line_2><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_addr_line_2"/></issuing_bank_address_line_2>
			<issuing_bank_dom><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_dom"/></issuing_bank_dom>
			<issuing_bank_reference><xsl:value-of select="$bankDetailsFromSellerBic/bank_details/bank_ref"/></issuing_bank_reference>
			<issuing_bank_iso_code><xsl:value-of select="//PushdThrghBaseln/SellrBk/BIC"/></issuing_bank_iso_code>
			<xsl:if test="//CreDtTm !=''">
				<iss_date>
					<xsl:value-of select="tools:convertISODateTime2MTPDateTime(//CreDtTm,$language)"/>
				</iss_date>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/PurchsOrdrRef/DtOfIsse !=''">
				<po_issue_date>
					<xsl:value-of select="//PushdThrghBaseln/PurchsOrdrRef/DtOfIsse"/>
				</po_issue_date>
			</xsl:if>
			<xsl:if test="//LatstMtchDt"> 
				<last_match_date>
					<xsl:value-of select="//LatstMtchDt"/>
				</last_match_date>
			</xsl:if>
			<xsl:if test="//TxId/Id"> 
				<tid>
			   		<xsl:value-of select="//TxId/Id"/>
			   	</tid>
		   	</xsl:if>
		   	<xsl:if test="//PushdThrghBaseln/PurchsOrdrRef/Id">
		   		<po_ref_id>
					<xsl:value-of select="//PushdThrghBaseln/PurchsOrdrRef/Id"/>
				</po_ref_id>
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
		   	
	   		<!-- Ship To Details -->
		   	<xsl:if test="//ShipTo">
		   		<xsl:apply-templates select="//ShipTo"/>
		   	</xsl:if>
		   	
	   		<!-- Consigne Details -->
		   	<xsl:if test="//Consgn">
		   		<xsl:apply-templates select="//Consgn"/>
		   	</xsl:if>
		   	
		   	<xsl:if test="//BuyrSdSubmitgBk/BIC">
			   	<buyer_submitting_bank_bic>
					<xsl:value-of select="//BuyrSdSubmitgBk/BIC"/>
				</buyer_submitting_bank_bic>
			</xsl:if>
			<xsl:if test="//SellrSdSubmitgBk/BIC">
				<seller_submitting_bank_bic>
					<xsl:value-of select="//SellrSdSubmitgBk/BIC"/>	
				</seller_submitting_bank_bic>
			</xsl:if>
						
			<xsl:if test="//Goods">
				<xsl:apply-templates select="//Goods"/>
		  	</xsl:if>
		  
  			<xsl:if test="//PushdThrghBaseln/PmtTerms  != ''">
	  			<xsl:choose>
		  			<xsl:when test="//PushdThrghBaseln/PmtTerms/Amt  != ''">
		  				<payment_terms_type>AMNT</payment_terms_type>
		  			</xsl:when>
		  			<xsl:otherwise>
		  				<payment_terms_type>PRCT</payment_terms_type>
		  			</xsl:otherwise>
	  			</xsl:choose>
				<payments>
				 	<xsl:apply-templates select="//PushdThrghBaseln/PmtTerms"/>
				</payments>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/SttlmTerms != ''">
				<xsl:apply-templates select="//PushdThrghBaseln/SttlmTerms"/>			
			</xsl:if>
			
			<bpo_used_status>
				<xsl:choose>
					<xsl:when test="//PushdThrghBaseln/PmtOblgtn != ''">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			</bpo_used_status>
			<xsl:if test="//PushdThrghBaseln/PmtOblgtn != ''">
				<bank_payment_obligation>
					<bpo>
	    				<xsl:apply-templates select="//PushdThrghBaseln/PmtOblgtn"/>
					</bpo>
					<bpo_xml>
					  <xsl:copy-of select="."/>
					</bpo_xml>
				</bank_payment_obligation>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/ComrclDataSetReqrd != ''">
				<commercial_dataset>
    				<xsl:apply-templates select="//PushdThrghBaseln/ComrclDataSetReqrd"/>
				</commercial_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/TrnsprtDataSetReqrd != ''">
				<transport_dataset>
    				<xsl:apply-templates select="//PushdThrghBaseln/TrnsprtDataSetReqrd"/>
				</transport_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/InsrncDataSetReqrd != ''">
				<insurance_dataset>
    				<xsl:apply-templates select="//PushdThrghBaseln/InsrncDataSetReqrd"/>
				</insurance_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/CertDataSetReqrd != ''">
				<certificate_dataset>
    				<xsl:apply-templates select="//PushdThrghBaseln/CertDataSetReqrd"/>
				</certificate_dataset>
			</xsl:if>
			<xsl:if test="//PushdThrghBaseln/OthrCertDataSetReqrd != ''">
				<other_certificate_dataset>
    				<xsl:apply-templates select="//PushdThrghBaseln/OthrCertDataSetReqrd"/>
				</other_certificate_dataset>
			</xsl:if>
			 <xsl:if test="//SellrCtctPrsn  != '' or //BuyrCtctPrsn !='' or //SellrBkCtctPrsn !='' or //BuyrBkCtctPrsn !='' or //OthrBkCtctPrsn !=''">
			   	<contacts>
			   		<xsl:if test="//SellrCtctPrsn  != ''">
				   		<xsl:apply-templates select="//SellrCtctPrsn">
				   			<xsl:with-param name="contact_type">01</xsl:with-param>
				   		</xsl:apply-templates>
			   		</xsl:if>
			   		<xsl:if test="//BuyrCtctPrsn  != ''">
				   		<xsl:apply-templates select="//BuyrCtctPrsn">
				   			<xsl:with-param name="contact_type">02</xsl:with-param>
				   		</xsl:apply-templates>
			   		</xsl:if>
				   	 <xsl:if test="//SellrBkCtctPrsn !=''">
				   	 	<xsl:apply-templates select="//SellrBkCtctPrsn">
				   			<xsl:with-param name="contact_type">03</xsl:with-param>
				   		</xsl:apply-templates>
				   	 </xsl:if>
				   	 <xsl:if test="//BuyrBkCtctPrsn !=''">
				   	 	<xsl:apply-templates select="//BuyrBkCtctPrsn">
				   			<xsl:with-param name="contact_type">04</xsl:with-param>
				   		</xsl:apply-templates>
				   	 </xsl:if>
				   	 <xsl:if test="//OthrBkCtctPrsn !=''">
				   	 	<xsl:apply-templates select="//OthrBkCtctPrsn">
				   			<xsl:with-param name="contact_type">08</xsl:with-param>
				   		</xsl:apply-templates>
				   	 </xsl:if>
			   	</contacts>
		   	</xsl:if>
		   	<xsl:if test="RtgSummry/IndvTrnsprt != ''">
		   			<xsl:apply-templates select="RtgSummry/IndvTrnsprt"/>		 
		    </xsl:if>
		    <xsl:if test="RtgSummry/MltmdlTrnsprt!=''">
				<xsl:if test="RtgSummry/MltmdlTrnsprt/TakngInChrg != ''">
					<taking_in_charge>
						<xsl:value-of select="RtgSummry/MltmdlTrnsprt/TakngInChrg"/>
					</taking_in_charge>
				</xsl:if>
				<xsl:if test="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn != ''">
					<final_dest_place>
						<xsl:value-of select="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn"/>
					</final_dest_place>
				</xsl:if>
		    </xsl:if>
		</ea_tnx_record>
	</xsl:template>
	
	<xsl:template match="//PushdThrghBaseln/PmtOblgtn" mode="update">
	<xsl:variable name="buyerBankBIC" select="//BuyrBk/BIC"/>
	<PmtOblgtn>
		<xsl:choose>
			<xsl:when test="$buyerBankBIC = ./OblgrBk/BIC">
				<buyer_bank_bpo>Y</buyer_bank_bpo>
			</xsl:when>
			<xsl:otherwise>
				<buyer_bank_bpo>N</buyer_bank_bpo>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="node()|@*" />
	</PmtOblgtn>
	</xsl:template>
	<xsl:template match="OblgrBk">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="RcptBk">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="Amt">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="Pctg">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="XpryDt">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="ChrgsAmt">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="ChrgsPctg">
		<xsl:copy-of select="." />
	</xsl:template>
  <xsl:template match="AplblLaw">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="PmtTerms">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="SttlmTerms">
		<xsl:copy-of select="." />
	</xsl:template>	
</xsl:stylesheet>
