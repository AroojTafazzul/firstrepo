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
	<!-- Transform MT798<741> (Response for Cancellation Request) into lc_tnx_record or el_tnx_record -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/>
	<xsl:param name="language">en</xsl:param>

	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT741']/DocRefNumber, 'LC,EL')"/>
		<xsl:choose>
			<xsl:when test="$productCode='LC'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT741']" mode="LC"/></xsl:when>
			<xsl:when test="$productCode='EL'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT741']" mode="EL"/></xsl:when>
	    </xsl:choose>
	</xsl:template>

    <xsl:template match="MeridianMessage" mode="LC">
   		<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocRefNumber, 'LC')"/>
   		    
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="DocRefNumber"/></bo_ref_id>
			<xsl:variable name="refid"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT741']/CustRefNumber"/></xsl:variable>
        	<ref_id><xsl:value-of select="$refid"/></ref_id>
        	<xsl:variable name="orgTnxRefNumber"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT741']/OriginalTxnRefNumber"/></xsl:variable>
	        <!-- Retrieve the tnx_id from the original tnx id being cancelled so that the right transaction is updated -->
	        <xsl:variable name="tnxid"><xsl:value-of select="service:retrieveTnxIdFromOrgTnxRef($refid, 'LC', $orgTnxRefNumber)"/></xsl:variable>
	    	<tnx_id><xsl:value-of select="$tnxid"/></tnx_id>   
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code>68</sub_tnx_type_code>
			<xsl:choose>
				<xsl:when test="CancellationRefusalStatus[.='CNCU' or .='CNBK']">
					<prod_stat_code>04</prod_stat_code>
				</xsl:when>
				<xsl:when test="CancellationRefusalStatus[.='REFU']">
					<prod_stat_code>01</prod_stat_code>
				</xsl:when>
				
			</xsl:choose>
			
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>

			<xsl:if test="MessageCreationDateTime">
				<xsl:apply-templates select="MessageCreationDateTime"/>
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
				<bo_tnx_id>
					<xsl:value-of select="BankReferenceNumber"/>
				</bo_tnx_id>
			</xsl:if>
			<xsl:if test="AdditonalCustReference">
				<cust_ref_id>
					<xsl:value-of select="AdditonalCustReference"/>
				</cust_ref_id>
			</xsl:if>
			
			<xsl:if test="ReasonForCancellationRefusal != ''">
				<bo_comment>
					<xsl:text>

				REASON FOR REFUSAL:
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="ReasonForCancellationRefusal"/>
						</xsl:with-param>
					</xsl:call-template>
				</bo_comment>
			</xsl:if>
			<xsl:if test="BankToCorporateInformation != ''">
				<free_format_text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template>
				</free_format_text>
			</xsl:if>
			<xsl:apply-templates select="IssuingBankA"/>
		    <xsl:apply-templates select="IssuingBankD"/>
		</lc_tnx_record>
    </xsl:template>
    
    
    <xsl:template match="MeridianMessage" mode="EL">
   		<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocRefNumber, 'EL')"/>
   		    
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
			<brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="DocRefNumber"/></bo_ref_id>
			<xsl:variable name="refid"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT741']/CustRefNumber"/></xsl:variable>
        	<ref_id><xsl:value-of select="$refid"/></ref_id>
	       <xsl:variable name="orgTnxRefNumber"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT741']/OriginalTxnRefNumber"/></xsl:variable>
	        <!-- Retrieve the tnx_id from the original tnx id being cancelled so that the right transaction is updated -->
	        <xsl:variable name="tnxid"><xsl:value-of select="service:retrieveTnxIdFromOrgTnxRef($refid, 'EL', $orgTnxRefNumber)"/></xsl:variable>
	        <tnx_id><xsl:value-of select="$tnxid"/></tnx_id> 
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code>68</sub_tnx_type_code>
			<xsl:choose>
				<xsl:when test="CancellationRefusalStatus[.='CNCU' or .='CNBK']">
					<prod_stat_code>04</prod_stat_code>
				</xsl:when>
				<xsl:when test="CancellationRefusalStatus[.='REFU']">
					<prod_stat_code>01</prod_stat_code>
				</xsl:when>
				
			</xsl:choose>
			
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>

			<xsl:if test="MessageCreationDateTime">
				<xsl:apply-templates select="MessageCreationDateTime"/>
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
				<bo_tnx_id>
					<xsl:value-of select="BankReferenceNumber"/>
				</bo_tnx_id>
			</xsl:if>
			<xsl:if test="AdditonalCustReference">
				<cust_ref_id>
					<xsl:value-of select="AdditonalCustReference"/>
				</cust_ref_id>
			</xsl:if>
			<xsl:if test="ReasonForCancellationRefusal != ''">
				<bo_comment>
					<xsl:text>

				REASON FOR REFUSAL:
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="ReasonForCancellationRefusal"/>
						</xsl:with-param>
					</xsl:call-template>
				</bo_comment>
			</xsl:if>
			<xsl:if test="BankToCorporateInformation != ''">
				<free_format_text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template>
				</free_format_text>
			</xsl:if>
			<xsl:apply-templates select="IssuingBankA"/>
		    <xsl:apply-templates select="IssuingBankD"/>
		</el_tnx_record>
    </xsl:template>

</xsl:stylesheet>