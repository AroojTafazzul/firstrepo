<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"		
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
		exclude-result-prefixes="localization service xsi utils">
	<!--
	   Copyright (c) 2000-2012 Misys (http://www.misys.com),
	   All Rights Reserved. 
	-->
	<!-- Transform MT798<794/791> (Request for Settlement of Charges) into lc_tnx_record or el_tnx_record-->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/> 
	<xsl:param name="language">en</xsl:param>

	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:variable name="borefid">
			<xsl:value-of select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" />
		</xsl:variable>
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId($borefid, 'LC,SR,BG,BR,SI,EL')"/>
		<xsl:variable name="refid">
			<xsl:value-of select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/CustomerReferenceNumber" />
		</xsl:variable>
		<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, $productCode)" />

		<xsl:variable name="bankIsoVerification">
			<xsl:choose>
				<xsl:when test="$productCode = 'SR' or $productCode = 'BR' or $productCode = 'EL'">
					<xsl:choose>
						<xsl:when test="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankA and MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankA != ''">
							<xsl:value-of select="service:checkIsoCodeFromBankReference($applRef, MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankA)"></xsl:value-of>
						</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankA and MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankA != ''">
							<xsl:value-of select="service:checkIsoCodeFromBankReference($applRef, MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankA)"></xsl:value-of>
						</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		
		<xsl:variable name="chargecurcode">
			<xsl:value-of select="substring(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']/CcyCodeAmount,1,3)"/>
		</xsl:variable>
		<xsl:variable name="issdate">
			<xsl:call-template name="format_date">
				<xsl:with-param name="input_date" select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT794']/DateOfIssue" />
			</xsl:call-template>
		</xsl:variable>
		
		
		<xsl:if test="$bankIsoVerification = 'true'">
			<xsl:choose>
				<xsl:when test="$productCode='LC'">
					<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']" mode="LC">
						<xsl:with-param name="refid" select="$refid"/>
						<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
						<xsl:with-param name="issdate" select="$issdate"/>
						<xsl:with-param name="applRef" select="$applRef"/>
						<xsl:with-param name="borefid" select="$borefid"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="$productCode='SR'">
					<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']" mode="SR">
						<xsl:with-param name="refid" select="$refid"/>
						<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
						<xsl:with-param name="issdate" select="$issdate"/>
						<xsl:with-param name="applRef" select="$applRef"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="$productCode='BG'">
					<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']" mode="BG">
						<xsl:with-param name="refid" select="$refid"/>
						<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
						<xsl:with-param name="issdate" select="$issdate"/>
						<xsl:with-param name="applRef" select="$applRef"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="$productCode='BR'">
					<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']" mode="BR">
						<xsl:with-param name="refid" select="$refid"/>
						<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
						<xsl:with-param name="issdate" select="$issdate"/>
						<xsl:with-param name="applRef" select="$applRef"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="$productCode='SI'">
					<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']" mode="SI">
						<xsl:with-param name="refid" select="$refid"/>
						<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
						<xsl:with-param name="issdate" select="$issdate"/>
						<xsl:with-param name="applRef" select="$applRef"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:when test="$productCode='EL'">
					<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT791']" mode="EL">
						<xsl:with-param name="refid" select="$refid"/>
						<xsl:with-param name="chargecurcode" select="$chargecurcode"/>
						<xsl:with-param name="issdate" select="$issdate"/>
						<xsl:with-param name="applRef" select="$applRef"/>
						<xsl:with-param name="borefid" select="$borefid"/>
					</xsl:apply-templates>
				</xsl:when>
		    </xsl:choose>
		</xsl:if>		
	</xsl:template>

    <xsl:template match="MeridianMessage" mode="LC">
    <xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
	<xsl:param name="applRef"/>
	<xsl:param name="borefid"/>
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="$borefid" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>24</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" /></doc_ref_no>
			<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankReferenceNumber" /></bo_tnx_id>
			<xsl:variable name="ccyAmt"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/CcyCodeAmount"/></xsl:variable>
			<xsl:if test="$ccyAmt">
				<!-- Credit amount -->
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring($ccyAmt,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_cur_code><xsl:value-of select="substring($ccyAmt,1,3)"/></tnx_cur_code>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/CreationDateTime">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/CreationDateTime"/>
			</xsl:if>
			 <xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/AdditionalCustomerReference">
			    <cust_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/AdditionalCustomerReference"/></cust_ref_id>
		     </xsl:if>
			<!-- Advising Bank -->
			<xsl:call-template name="add-advising-bank"/>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding Bo_comments -->
			<bo_comment>
		<!-- Appending sender to receiver info and Bank To Corporate Information (as per the confirmation from BA) to bo comment-->
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo != ''">
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo" />
					</xsl:with-param>
				</xsl:call-template><xsl:text>
					</xsl:text>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation != ''">
				<xsl:text>

BANK TO CORPORATE INFO:
				</xsl:text>
				<xsl:text>
</xsl:text>
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation" />
					</xsl:with-param>
				</xsl:call-template><xsl:text>
					</xsl:text>
			</xsl:if>
		 </bo_comment>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
			</xsl:call-template>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/FileIdentification!=''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/FileIdentification"/>
			</xsl:if>
		</lc_tnx_record>
    </xsl:template>
    
    <xsl:template match="MeridianMessage" mode="BG">
    <xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
	<xsl:param name="applRef"/>
		<bg_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd">
			<xsl:variable name="processingbankidentifier"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/ProcessingBankIdentifier"/></xsl:variable>
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>24</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>BG</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" /></doc_ref_no>
			<!-- Advising Bank -->
			<xsl:call-template name="add-advising-bank"/>
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
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo != ''">
					<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			 </bo_comment>
			
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
			</xsl:call-template>
		</bg_tnx_record>
    </xsl:template>   
    
    <xsl:template match="MeridianMessage" mode="SR">
    <xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
	<xsl:param name="applRef"/>
		<sr_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/sr.xsd">
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>24</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>SR</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<beneficiary_reference><xsl:value-of select="$applRef" /></beneficiary_reference>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" /></doc_ref_no>
			<!-- Issuing Bank is populated in case of SR -->
			<xsl:call-template name="add-issuing-bank"/>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding Bo_comments -->
			<xsl:call-template name="add-bocomments"/>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
			</xsl:call-template>
		</sr_tnx_record>
    </xsl:template> 
    
    <xsl:template match="MeridianMessage" mode="BR">
    <xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
	<xsl:param name="applRef"/>
		<br_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd">
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>24</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>BR</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<beneficiary_reference><xsl:value-of select="$applRef" /></beneficiary_reference>
			<related_ref>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT791']/RelatedReference and ../MeridianMessage[ExternalMessageType = 'MT791']/RelatedReference != ''">
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/RelatedReference" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</related_ref>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" /></doc_ref_no>
			<!-- Issuing Bank is populated in case of SR -->
			<xsl:call-template name="add-issuing-bank"/>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<bo_comment>
				<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo != ''">
					<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			 </bo_comment>			

			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
			</xsl:call-template>
		</br_tnx_record>
    </xsl:template> 
    
    <xsl:template match="MeridianMessage" mode="SI">
    <xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
	<xsl:param name="applRef"/>
		<si_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd">
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>24</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>SI</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<doc_ref_no><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" /></doc_ref_no>
			<!-- Advising Bank -->
			<xsl:call-template name="add-advising-bank"/>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding Bo_comments -->
			<xsl:call-template name="add-bocomments"/>
			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
			</xsl:call-template>
		</si_tnx_record>
    </xsl:template>
    
    
    <xsl:template match="MeridianMessage" mode="EL">
    <xsl:param name="refid"/>
	<xsl:param name="chargecurcode"/>
	<xsl:param name="issdate"/>
	<xsl:param name="applRef"/>
	<xsl:param name="borefid"/>
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="$borefid" /></bo_ref_id>
			<lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/DocReferenceNo" /></lc_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>24</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			<iss_date><xsl:value-of select="$issdate" /></iss_date>
			<beneficiary_reference><xsl:value-of select="$applRef" /></beneficiary_reference>
			<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankReferenceNumber" /></bo_tnx_id>
			<xsl:variable name="ccyAmt"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/CcyCodeAmount"/></xsl:variable>
			<xsl:if test="$ccyAmt">
				<!-- Credit amount -->
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring($ccyAmt,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_cur_code><xsl:value-of select="substring($ccyAmt,1,3)"/></tnx_cur_code>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/CreationDateTime">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/CreationDateTime"/>
			</xsl:if>
			 <xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/AdditionalCustomerReference">
			    <cust_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/AdditionalCustomerReference"/></cust_ref_id>
		     </xsl:if>
			
			<!-- Issuing Bank is populated in case of SR -->
			<xsl:call-template name="add-issuing-bank"/>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<bo_comment>
				<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo != ''">
					<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			 </bo_comment>			

			<!-- CHARGES -->
			<xsl:call-template name="add-charges">
				<xsl:with-param name="issdate" select="$issdate"/>
			</xsl:call-template>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/FileIdentification!=''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/FileIdentification"/>
			</xsl:if>
		</el_tnx_record>
    </xsl:template> 
    
    <xsl:template name="add-charges">
  	  <xsl:param name="issdate"/>
    
    	<xsl:variable name="chargecurcode">
			<xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT791']/CcyCodeAmount,1,3)"/>
		</xsl:variable>
		<xsl:variable name="chargeamt">
			<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT791']/CcyCodeAmount,4)"/></xsl:with-param></xsl:call-template>
		</xsl:variable>
  		<!-- charge details set as "OTHER". status set as settled. date as settlement date. charge is "OTHER". -->
    	<charges>
			<charge>
				<!-- <chrg_id>0</chrg_id> -->
				<chrg_code>OTHER</chrg_code>
				<amt><xsl:value-of select="$chargeamt" /></amt>
				<cur_code><xsl:value-of select="$chargecurcode" /></cur_code>
				<status>99</status>
				<!-- to be set as "01" for LC and "02" for EL -->
				<bearer_role_code>01</bearer_role_code>
				<!-- to be same as iss_date -->
				<inception_date><xsl:value-of select="$issdate" /></inception_date>
				<additional_comment>
					<xsl:value-of select="localization:getGTPString($language, 'CHARGE_DETAILS')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/DetailsOfCharges" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
				</additional_comment>
				<!-- TODO: Value to be observed -->
				<created_in_session>Y</created_in_session>
			</charge>
		</charges>
    </xsl:template>
    
    <xsl:template name="add-bocomments">
  	  <bo_comment>
		<!-- Appending sender to receiver info to bo_comment -->
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo != ''">
			<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
					<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT791']/SenderToReceiverInfo" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	 </bo_comment>
    </xsl:template>
    
    <xsl:template name="add-narrative">
   		<narrative_additional_instructions>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation != ''">
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT794']/BankToCorporateInformation" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</narrative_additional_instructions>
    </xsl:template>
    
    <xsl:template name="add-advising-bank">
    	<xsl:choose>
			<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankA and ../MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankA != ''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankA"/>
			</xsl:when>
			<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankD and ../MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankD != ''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/AdvisingBankD"/>
			</xsl:when>
		</xsl:choose>
    </xsl:template>
    
    <xsl:template name="add-issuing-bank">
    	<xsl:choose>
			<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankA and ../MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankA != ''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankA"/>
			</xsl:when>
			<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankD and ../MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankD != ''">
				<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT794']/IssuingBankD"/>
			</xsl:when>
		</xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>