<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization service xsi utils defaultresource">
	<!-- Copyright (c) 2000-2012 Misys (http://www.misysbanking.com), All Rights 
		Reserved. -->
	<!-- Transform MT798<793/790> Notification of Settlement of Charges for 
		LC and EL -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl" />
	<xsl:param name="reference" />
	<xsl:param name="language">en</xsl:param>
	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT793']/UndertakingNumber, 'LC,SR,BG,BR,SI,EL')" />
		<xsl:variable name="refid">
				<xsl:value-of select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT793']/CustomerReferenceNumber" />
		</xsl:variable>
		<xsl:variable name="chargecurcode">
			<xsl:choose>
				<xsl:when test="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD and MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD != ''">
					<xsl:value-of select="substring(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD,7,3)" />
				</xsl:when>
				<xsl:when test="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC and MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC != ''">
					<xsl:value-of select="substring(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC,7,3)" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="issdate">
			<xsl:call-template name="format_date">
				<xsl:with-param name="input_date" select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT793']/DateOfIssue" />
			</xsl:call-template>
		</xsl:variable>
			
		<xsl:choose>
			<xsl:when test="$productCode='LC'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']" mode="LC">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='SR'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']" mode="SR">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='BG'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']" mode="BG">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='BR'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']" mode="BR">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='SI'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']" mode="SI">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='EL'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT790']" mode="EL">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
	    </xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="MeridianMessage" mode="LC">
	<xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
		<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
    	<xsl:variable name="boRefId">
    		<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/UndertakingNumber"/>
    	</xsl:variable>
    	<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId($boRefId, 'LC')"/>
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<!-- <xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'LC')" /> -->
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="$boRefId" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>16</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/CreationDateTime">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT793']/CreationDateTime"/>
			</xsl:if>
			<!-- <applicant_reference><xsl:value-of select="$applRef" /></applicant_reference> -->
			
			<xsl:variable name="applRef">
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
			</xsl:variable>
			<applicant_reference> 
				<xsl:value-of select="$applRef"/>
 			</applicant_reference>
 			
			<!-- Add fee account -->
			<xsl:call-template name="add-fee-account"><xsl:with-param name="applRef" select="$applRef"/></xsl:call-template>
			<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankReferenceNumber" /></bo_tnx_id>
			 <xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/AddtlCustomerReference">
			    <cust_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/AddtlCustomerReference"/></cust_ref_id>
		     </xsl:if>
			<!-- Setting bank to corporate info to narrative additional instructions -->
<!-- 			<xsl:call-template name="add-narrative"/> -->
			<!-- Adding back office comments -->
			<xsl:call-template name="add-bocomments"/>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
				<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
			</xsl:call-template>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/FileIdentification!=''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT793']/FileIdentification"/>
			</xsl:if>
		</lc_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="BG">
	<xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
		<bg_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd">
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'BG')" />
			<xsl:variable name="processingbankidentifier"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/ProcessingBankIdentifier"/></xsl:variable>
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>16</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>BG</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<!-- Add fee account -->
			<xsl:call-template name="add-fee-account"><xsl:with-param name="applRef" select="$applRef"/></xsl:call-template>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/DocReferenceNo" /></doc_ref_no>
			<xsl:if test="$processingbankidentifier != ''">
				<xsl:variable name="processingBank" select="utils:getProcessingBank($refid , '', $processingbankidentifier)"/>
				<processing_bank>
					<abbv_name><xsl:value-of select="$processingBank/processing_bank/abbv_name"></xsl:value-of></abbv_name>
					<name><xsl:value-of select="$processingBank/processing_bank/name"></xsl:value-of></name>
					<address_line_1><xsl:value-of select="$processingBank/processing_bank/address_line_1"></xsl:value-of></address_line_1>
					<address_line_2><xsl:value-of select="$processingBank/processing_bank/address_line_2"></xsl:value-of></address_line_2>
					<dom><xsl:value-of select="$processingBank/processing_bank/address_dom"></xsl:value-of></dom>
					<iso_code><xsl:value-of select="$processingBank/processing_bank/iso_code"></xsl:value-of></iso_code>
				</processing_bank>
			</xsl:if>
			<bo_comment>
			<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo != ''">
					<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
			
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
				<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
			</xsl:call-template>
		</bg_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="SR">
	<xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
		<sr_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/sr.xsd">
		
			<!-- For SR, applRef contains beneficiary reference -->
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'SR')" />
		
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>16</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>SR</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<beneficiary_reference><xsl:value-of select="$applRef"/></beneficiary_reference>
			<!-- Add fee account -->
			<xsl:call-template name="add-fee-account"><xsl:with-param name="applRef" select="$applRef"/></xsl:call-template>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/DocReferenceNo" /></doc_ref_no>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding back office comments -->
			<xsl:call-template name="add-bocomments"/>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
				<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
			</xsl:call-template>
		</sr_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="BR">
	<xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
		<br_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd">
		
			<!-- For BR, applRef contains beneficiary reference -->
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'BR')" />
		
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>16</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>BR</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<beneficiary_reference><xsl:value-of select="$applRef"/></beneficiary_reference>
			<related_ref>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT790']/RelatedRef and ../MeridianMessage[ExternalMessageType = 'MT790']/RelatedRef != ''">
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/RelatedRef" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</related_ref>
			
			<!-- Add fee account -->
			<xsl:call-template name="add-fee-account"><xsl:with-param name="applRef" select="$applRef"/></xsl:call-template>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/DocReferenceNo" /></doc_ref_no>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<bo_comment>
			<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo != ''">
					<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
			
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
				<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
			</xsl:call-template>
		</br_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="SI">
	<xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
		<si_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd">
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'SI')" />
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>16</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>SI</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<!-- Add fee account -->
			<xsl:call-template name="add-fee-account"><xsl:with-param name="applRef" select="$applRef"/></xsl:call-template>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/DocReferenceNo" /></doc_ref_no>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding back office comments -->
			<xsl:call-template name="add-bocomments"/>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
				<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
			</xsl:call-template>
		</si_tnx_record>
	</xsl:template>
	
	
	<xsl:template match="MeridianMessage" mode="EL">
	<xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
			<!-- For EL, applRef contains beneficiary reference -->
			<xsl:variable name="boRefId">
    			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/UndertakingNumber"/>
    		</xsl:variable>
			<xsl:variable name="cust-reference-enabled">
    			<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    		</xsl:variable>
    		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId($boRefId, 'EL')"/>
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/DocReferenceNo" /></lc_ref_id>
			<bo_ref_id><xsl:value-of select="$boRefId" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>16</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/CreationDateTime">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT793']/CreationDateTime"/>
			</xsl:if>
			<xsl:variable name="applRef">
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
			</xsl:variable>
			<beneficiary_reference><xsl:value-of select="$applRef"/></beneficiary_reference>
			<!-- Add fee account -->
			<xsl:call-template name="add-fee-account"><xsl:with-param name="applRef" select="$applRef"/></xsl:call-template>
			<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankReferenceNumber" /></bo_tnx_id>
			 <xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']//AddtlCustomerReference">
			    <cust_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']//AddtlCustomerReference"/></cust_ref_id>
		     </xsl:if>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<bo_comment>
			<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo != ''">
					<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
				<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
			</xsl:call-template>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/FileIdentification!=''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT793']/FileIdentification"/>
			</xsl:if>
		</el_tnx_record>
	</xsl:template>
	
    <xsl:template name="add-charges">
  	  <xsl:param name="issdate"/>
  	  <xsl:param name="chargecurcode"/>
  	  
  	   <xsl:variable name="chargedate">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD and ../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD != ''">
					<xsl:call-template name="format_date">
						<xsl:with-param name="input_date"
							select="normalize-space(ValueDateCcyAmountD)" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC and ../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC != ''">
					<xsl:call-template name="format_date">
						<xsl:with-param name="input_date"
							select="normalize-space(ValueDateCcyAmountC)" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="chargetype">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD and ../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD != ''">D</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC and ../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC != ''">C</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="chargeamt">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD and ../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountD != ''">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount">
							<xsl:value-of select="substring(ValueDateCcyAmountD,10)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC and ../MeridianMessage[ExternalMessageType = 'MT790']/ValueDateCcyAmountC != ''">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount">
							<xsl:value-of select="substring(ValueDateCcyAmountC,10)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
			
    	<!-- charge details set as "OTHER". status set as settled. date as settlement date. charge is "OTHER". -->
		<charges>
			<charge>
				<!-- <chrg_id>0</chrg_id> -->
				<chrg_code>OTHER</chrg_code>
				<amt><xsl:value-of select="$chargeamt" /></amt>
				<cur_code><xsl:value-of select="$chargecurcode" /></cur_code>
				<status>01</status>
				<!-- to be set as "01" for LC and "02" for EL -->
				<bearer_role_code>01</bearer_role_code>
				<!-- to be same as iss_date -->
				<inception_date><xsl:value-of select="$issdate" /></inception_date>
				<settlement_date><xsl:value-of select="$chargedate" /></settlement_date>
				<additional_comment>
					<xsl:value-of select="localization:getGTPString($language, 'CHARGE_DETAILS')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/DetailsOfCharges" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</additional_comment>
				<!-- TODO: Value to be observed -->
				<created_in_session>Y</created_in_session>
				<chrg_type><xsl:value-of select="$chargetype" /></chrg_type>
			</charge>
		</charges>
    </xsl:template>
    
    <xsl:template name="add-bocomments">
  		 <bo_comment>
			<!-- Appending sender to receiver info to bo_comment -->
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo != ''">
			<xsl:text>
			SENDER TO RECEIVER INFORMATION: 
			</xsl:text>
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/SenderToReceiverInfo" />
					</xsl:with-param>
				</xsl:call-template><xsl:text>
</xsl:text>
			</xsl:if>
			<!-- MPS-53344 fix-->
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation != ''">
			<xsl:text>
			
			BANK TO CORPORATE INFORMATION:

			</xsl:text>
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation" />
					</xsl:with-param>
				</xsl:call-template><xsl:text>
</xsl:text>
			</xsl:if>
		</bo_comment>
    </xsl:template>
    
    <xsl:template name="add-narrative">
   		<narrative_additional_instructions>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation != ''">
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT793']/BankToCorporateInformation" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</narrative_additional_instructions>
    </xsl:template>
    
    <xsl:template name="add-fee-account">
    <xsl:param name="applRef"/>
    	<xsl:variable name="feeAcoountExists" select="service:checkAccountBasedOnReference($applRef, ../MeridianMessage[ExternalMessageType = 'MT790']/AccountId)" />
    	<xsl:if test="$feeAcoountExists = 'true'">
			<fee_act_no>
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT790']/AccountId" />
			</fee_act_no>
		</xsl:if>
    </xsl:template>
</xsl:stylesheet>