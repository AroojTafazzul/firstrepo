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
	<!-- Transform MT798<736> (Notification of Acceptance/Refusal of Amendment) into lc_tnx_record -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="product_code">LC</xsl:param>

	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT736']" />
	</xsl:template>

    <xsl:template match="MeridianMessage">
     	<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'LC')"/>
   		
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<brch_code>00001</brch_code>
        	<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
        	<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT736']/BankReferenceNumber"/></bo_tnx_id>
        	<xsl:variable name="tnxid"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT736']/CustomerReferenceNumber"/></xsl:variable>
			<ref_id><xsl:value-of select="service:retrieveRefIdFromTnxId($tnxid, $product_code)"/></ref_id>
			<tnx_id><xsl:value-of select="$tnxid"/></tnx_id>
			<tnx_type_code>03</tnx_type_code>
<!-- 			<sub_tnx_type_code/>  -->
			<prod_stat_code>
				<xsl:choose>
					<xsl:when test="AcceptanceNotification[.='ACCP']">04</xsl:when>
					<xsl:otherwise>01</xsl:otherwise>
				</xsl:choose>
			</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>
			<xsl:apply-templates select="DateOfIssue"/>

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
 			<xsl:apply-templates select="IssuingBankA"/>
			<xsl:apply-templates select="IssuingBankD"/>
			<xsl:variable name="result">
				<xsl:choose>
					<xsl:when test="AcceptanceNotification[.='ACCP']">ACCEPTANCE</xsl:when>
					<xsl:otherwise>REFUSAL</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<bo_comment>
				<xsl:text>
				This is a notification of
				</xsl:text>
				<xsl:value-of select="$result"/>
				<xsl:text> of Amendment.
				See the attached SWIFT message for all details.
				
				</xsl:text>
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:text>
					BANK TO CORPORATE INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:choose>
								<xsl:when test="$cust-reference-enabled = 'true'">
									<xsl:value-of select="substring-after(BankToCorporateInformation, '\n')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="BankToCorporateInformation"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</bo_comment>
			<xsl:apply-templates select="DateOfAmendment"/>
			<xsl:apply-templates select="NumberOfAmendment"/>
			<xsl:apply-templates select="FileIdentification"/>
		</lc_tnx_record>

    </xsl:template>
    
</xsl:stylesheet>