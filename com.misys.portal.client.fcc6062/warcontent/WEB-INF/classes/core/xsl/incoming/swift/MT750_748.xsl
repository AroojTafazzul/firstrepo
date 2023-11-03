<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"	
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"	
		exclude-result-prefixes="localization service defaultresource">
	<!--
		Copyright (c) 2000-2012 Misys (http://www.misys.com),
   		All Rights Reserved. 
	-->
	<!-- Transform Advice of discrepancy (B2C) MT798<748/750> into lc_tnx_record -->
	<!-- Import common functions -->
	
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/> 
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="product_code">LC</xsl:param> 
	  
	<xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT748']"/>
    </xsl:template>

	<xsl:template match="MeridianMessage">
    	<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'LC')"/>
   			
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>12</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>

			<xsl:if test="DateOfDocumentsRcpt">
				<tnx_val_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="DateOfDocumentsRcpt"/></xsl:call-template></tnx_val_date>
			</xsl:if>	
			<xsl:apply-templates select="DateOfIssue"/>
			<!-- xsl:apply-templates select="Beneficiary"/ -->

			<!-- IF the principal amount is included in the 750, update it -->
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT750']/PrincipalAmount">
					<claim_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT750']/PrincipalAmount,1,3)"/></claim_cur_code>
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount">
							<xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT750']/PrincipalAmount,4)"/></xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<claim_amt><xsl:value-of select="$amount"/></claim_amt>
				</xsl:when>
				<!-- IF the principal amount is included in the 748, update it -->
				<xsl:when test="PrincipalAmount">
					<claim_cur_code><xsl:value-of select="substring(PrincipalAmount,1,3)"/></claim_cur_code>
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount">
							<xsl:with-param name="amount"><xsl:value-of select="substring(PrincipalAmount,4)"/></xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<claim_amt><xsl:value-of select="$amount"/></claim_amt>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="CustomerReferenceNumber != '' and CustomerReferenceNumber != 'NONREF'">
					<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
				</xsl:when>
				<xsl:otherwise>
					<ref_id><xsl:value-of select="service:retrieveRefIdFromBoRefId(DocCreditNo, $product_code, null, null)"/></ref_id>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="AdditionalCustomerReference != ''">
				<cust_ref_id><xsl:value-of select="AdditionalCustomerReference"/></cust_ref_id>
			</xsl:if>
			<xsl:if test="SendersRef">
				<doc_ref_no><xsl:value-of select="SendersRef"/></doc_ref_no>
			</xsl:if>
			<xsl:if test="RelatedRef != ''">
				<lc_ref_id><xsl:value-of select="RelatedRef"/></lc_ref_id>
			</xsl:if>
			<xsl:if test="WaiverPeriodEndDate != ''">
				<latest_answer_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="WaiverPeriodEndDate"/></xsl:call-template></latest_answer_date>
			</xsl:if>
			<xsl:if test="CreationDateTime != ''">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<applicant_reference> 
				<xsl:choose>
					<xsl:when test="$cust-reference-enabled = 'true'">
						<xsl:call-template name="extract_customer_reference">
							<xsl:with-param name="input" select="BankToCorporateInformation"/>
							<xsl:with-param name="prefix">CUST/</xsl:with-param>
						</xsl:call-template>					
					</xsl:when>
					<xsl:when test="$cust-reference-enabled = 'false'">
						<xsl:value-of select="$cust-reference"/>	
					</xsl:when>
				</xsl:choose>
 			</applicant_reference>			

			<xsl:if test="BankReferenceNumber">
				<bo_tnx_id><xsl:value-of select="BankReferenceNumber"/></bo_tnx_id>
			</xsl:if>
 			
			<bo_comment>
				<!-- We add the rest of the information from the bank to corp from the MT748 too -->			
				<xsl:text>This is an Advice of Discrepancy.</xsl:text>
				<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				<xsl:text>See the attached SWIFT message for all details.</xsl:text>
				<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:text>BANK TO CORPORATE INFO:</xsl:text>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(BankToCorporateInformation, '\n')"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT750']/SenderToReceiverInfo != ''">
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:text>SEND TO RECEIVER INFO:</xsl:text>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT750']/SenderToReceiverInfo"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				<xsl:choose>
					<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT750']/Discepancies">
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<xsl:text>DISCREPANCIES:</xsl:text>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<!-- We add the discrepancies from the 750. 
							Notice the misspelling in the Meridian XML -->
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT750']/Discepancies"/>
							</xsl:with-param>
						</xsl:call-template><xsl:text>
						</xsl:text>
					</xsl:when>
					<xsl:when test="Discrepancies">
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<xsl:text>DISCREPANCIES:</xsl:text>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<!-- We add the discrepancies from the 748. 
							Notice the misspelling in the Meridian XML -->
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT748']/Discrepancies"/>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</bo_comment>
			<xsl:apply-templates select="IssuingBankA"/>
			<xsl:apply-templates select="IssuingBankD"/>
			<xsl:text>
			ISSUING BANK CONTACT:
			</xsl:text>	
			<xsl:if test="IssuingBankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="IssuingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			<xsl:apply-templates select="NominatedConfirmingBankA"/>	
			<xsl:apply-templates select="NominatedConfirmingBankD"/>
			<xsl:apply-templates select="Beneficiary"/>
			<xsl:apply-templates select="SenderToReceiverInfo"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT748']/FileIdentification"/>
			<cross_references>
				<cross_reference>
		            <brch_code>00001</brch_code>
					<product_code>LC</product_code>
		            <type_code>01</type_code>			
				</cross_reference>
			</cross_references>
			<action_req_code>12</action_req_code>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT748']/FileIdentification!=''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT748']/FileIdentification"/>
			</xsl:if>
		</lc_tnx_record>
    </xsl:template>

</xsl:stylesheet>
