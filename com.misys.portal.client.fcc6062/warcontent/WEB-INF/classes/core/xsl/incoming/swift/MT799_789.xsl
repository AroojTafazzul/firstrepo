<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
	exclude-result-prefixes="localization service xsi utils">
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
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber, 'LC,SR,BG,BR,SI,EL')" />
		<xsl:variable name="refid">
				<xsl:value-of select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT789']/CustomerReferenceNumber" />
		</xsl:variable>
		<xsl:variable name="issdate">
			<xsl:call-template name="format_date">
				<xsl:with-param name="input_date" select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT789']/DateOfIssue" />
			</xsl:call-template>
		</xsl:variable>
			
		<xsl:choose>
			<xsl:when test="$productCode='LC'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799'][1]" mode="LC">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='SR'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799'][1]" mode="SR">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='BG'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799'][1]" mode="BG">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='BR'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799'][1]" mode="BR">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='SI'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799'][1]" mode="SI">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$productCode='EL'">
				<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT799'][1]" mode="EL">
					<xsl:with-param name="refid" select="$refid"/>
					<xsl:with-param name="issdate" select="$issdate"/>
				</xsl:apply-templates>
			</xsl:when>
	    </xsl:choose>
	</xsl:template>

	<xsl:template match="MeridianMessage" mode="LC">
		<xsl:param name="refid"/>
		<xsl:param name="issdate"/>
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'LC')" />
			<brch_code>00001</brch_code>
			<xsl:if test="CustomerReferenceNumber">
				<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<xsl:if test="BankReferenceNumber">
				<doc_ref_no><xsl:value-of select="BankReferenceNumber"/></doc_ref_no>
			</xsl:if>
			<xsl:if test="BankReferenceNumber">
				<bo_tnx_id><xsl:value-of select="BankReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			<xsl:if test="AdditionalCustomerReference">
				<cust_ref_id><xsl:value-of select="AdditionalCustomerReference"/></cust_ref_id>
			</xsl:if>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT789']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT789']/BankContact != ''">
				<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankContact"/>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding back office comments -->
			<bo_comment>
				<xsl:if test="count(../MeridianMessage[ExternalMessageType = 'MT799']/Narrative[. != '']) != 0">
					<xsl:value-of select="localization:getGTPString($language, 'NARRATIVE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT799']" mode="narrative">
						<xsl:sort select="substring-before(MessageIndexAndTotal,'/')" data-type="number"/>
					</xsl:apply-templates>
				</xsl:if>
			</bo_comment>
			 <xsl:if test="FileIdentification">
			 <xsl:apply-templates select="FileIdentification"/> 
			 </xsl:if>
		</lc_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="BG">
		<xsl:param name="refid"/>
		<xsl:param name="issdate"/>
		<bg_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd">
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'BG')" />
			<xsl:variable name="processingbankidentifier"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/ProcessingBankIdentifier"/></xsl:variable>
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>BG</product_code>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
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
			
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<!-- <xsl:call-template name="add-narrative"/>
			Adding back office comments
			<xsl:call-template name="add-bocomments"/> -->
			
			<bo_comment>
				<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="count(../MeridianMessage[ExternalMessageType = 'MT799']/Narrative[. != '']) != 0">
					<xsl:value-of select="localization:getGTPString($language, 'NARRATIVE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT799']" mode="narrative">
						<xsl:sort select="substring-before(MessageIndexAndTotal,'/')" data-type="number"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
			
		</bg_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="SR">
		<xsl:param name="refid"/>
		<xsl:param name="issdate"/>
		<sr_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/sr.xsd">
			<!-- applRef here is the bene ref -->
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'SR')" />
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>SR</product_code>
			<beneficiary_reference><xsl:value-of select="$applRef"/></beneficiary_reference>
			
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding back office comments -->
			<xsl:call-template name="add-bocomments"/>
		</sr_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="BR">
		<xsl:param name="refid"/>
		<xsl:param name="issdate"/>
		<br_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd">
			<!-- applRef here is the bene ref -->
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'BR')" />
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>BR</product_code>
			<beneficiary_reference><xsl:value-of select="$applRef"/></beneficiary_reference>
			<bo_comment>
				<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="count(../MeridianMessage[ExternalMessageType = 'MT799']/Narrative[. != '']) != 0">
					<xsl:value-of select="localization:getGTPString($language, 'NARRATIVE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT799']" mode="narrative">
						<xsl:sort select="substring-before(MessageIndexAndTotal,'/')" data-type="number"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
		</br_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="SI">
		<xsl:param name="refid"/>
		<xsl:param name="issdate"/>
		<si_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd">
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'SI')" />
			<brch_code>00001</brch_code>
			<xsl:if test="CustomerReferenceNumber">
				<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>SI</product_code>
			<applicant_reference><xsl:value-of select="$applRef" /></applicant_reference>
			<xsl:if test="BankReferenceNumber">
				<doc_ref_no><xsl:value-of select="BankReferenceNumber"/></doc_ref_no>
			</xsl:if>
			<xsl:if test="BankReferenceNumber">
				<bo_tnx_id><xsl:value-of select="BankReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			<xsl:if test="AdditionalCustomerReference">
				<cust_ref_id><xsl:value-of select="AdditionalCustomerReference"/></cust_ref_id>
			</xsl:if>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT789']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT789']/BankContact != ''">
				<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankContact"/>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:if>	
			<!-- Setting bank to corporate info to narrative additional instructions -->
			<xsl:call-template name="add-narrative"/>
			<!-- Adding back office comments -->
			<xsl:call-template name="add-bocomments"/>
			 <xsl:if test="FileIdentification">
			 <xsl:apply-templates select="FileIdentification"/> 
			 </xsl:if>
		</si_tnx_record>
	</xsl:template>
	
	<xsl:template match="MeridianMessage" mode="EL">
		<xsl:param name="refid"/>
		<xsl:param name="issdate"/>
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
			<!-- applRef here is the bene ref -->
			<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($refid, 'EL')" />
			<brch_code>00001</brch_code>
			<ref_id><xsl:value-of select="$refid" /></ref_id>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT799']/RelatedReference and ../MeridianMessage[ExternalMessageType = 'MT799']/RelatedReference != ''">
				<lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT799']/RelatedReference" /></lc_ref_id>
			</xsl:if>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankReferenceNumber" /></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code />
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			<beneficiary_reference><xsl:value-of select="$applRef"/></beneficiary_reference>
			<bo_comment>
				<!-- Appending sender to receiver info to bo_comment -->
				<xsl:if test="count(../MeridianMessage[ExternalMessageType = 'MT799']/Narrative[. != '']) != 0">
					<xsl:value-of select="localization:getGTPString($language, 'NARRATIVE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT799']" mode="narrative">
						<xsl:sort select="substring-before(MessageIndexAndTotal,'/')" data-type="number"/>
					</xsl:apply-templates>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation != ''">
					<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
					<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
		</el_tnx_record>
	</xsl:template>
	
	
    <xsl:template name="add-bocomments">
  		 <bo_comment>
			<!-- Appending sender to receiver info to bo_comment -->
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT799']" mode="narrative">
				<xsl:sort select="substring-before(MessageIndexAndTotal,'/')" data-type="number"/>
			</xsl:apply-templates>
		</bo_comment>
    </xsl:template>
    
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT799']" mode="narrative">
		<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="Narrative"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
    </xsl:template>
    
    <xsl:template name="add-narrative">
   		<narrative_sender_to_receiver>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation != ''">
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT789']/BankToCorporateInformation" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</narrative_sender_to_receiver>
    </xsl:template>
    
</xsl:stylesheet>