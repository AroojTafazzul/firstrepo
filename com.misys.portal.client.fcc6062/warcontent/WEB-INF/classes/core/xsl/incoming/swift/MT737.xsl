<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		exclude-result-prefixes="localization">
	<!--
		Copyright (c) 2000-2012 Misys (http://www.misysbanking.com),
		All Rights Reserved. 
	-->
	<!-- Transform MT798<737> (Response to Documentary Credit Presentation) into lc_tnx_record  or el_tnx_record-->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/> 
	<xsl:param name="language">en</xsl:param> 

    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT737']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage">
    	<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
    		<xsl:variable name="lcRefid"><xsl:value-of select="CustomerReferenceNumber"/></xsl:variable>
			<xsl:variable name="refid"><xsl:value-of select="service:retrieveRefIdFromMasterByLCRefId($lcRefid, 'EL')"/></xsl:variable>
			<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'EL')"/>
	        <brch_code>00001</brch_code>  
	        <xsl:if test="CustomerReferenceNumber">
				<lc_ref_id><xsl:value-of select="$lcRefid"/></lc_ref_id>
				<ref_id><xsl:value-of select="$refid"/></ref_id>
			</xsl:if>   	             
			<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
			<xsl:if test="BankReferenceNumber">
				<bo_tnx_id><xsl:value-of select="BankReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>		
			<prod_stat_code>
				<xsl:choose>
					<xsl:when test="AcceptanceNotification[.='COMP']">04</xsl:when>
					<xsl:otherwise>01</xsl:otherwise>
				</xsl:choose>
			</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			
			<xsl:if test="DateOfPresentation">
				<tnx_val_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="DateOfPresentation"/></xsl:call-template></tnx_val_date>
			</xsl:if>			
			<beneficiary_reference><xsl:value-of select="$cust-reference"/></beneficiary_reference>
			 
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:apply-templates select="DateOfIssue"/>
			<!-- ISSUING BANK -->
			<xsl:apply-templates select="IssuingBankA"/>
			<xsl:apply-templates select="IssuingBankD"/>
			
			<xsl:apply-templates select="NominatedConfirmingBankA"/>	
			<xsl:apply-templates select="NominatedConfirmingBankD"/>
			<xsl:if test="PresentationAmount">
				<tnx_cur_code><xsl:value-of select="substring(PresentationAmount,1,3)"/></tnx_cur_code>
				<!-- Credit amount -->
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(PresentationAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if>
						
			<xsl:if test="NominatedConfirmingBankContact != ''">
			<xsl:text>
NOMINATED/CONFIRMING BANK CONTACT:
			</xsl:text>	
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="NominatedConfirmingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			<xsl:variable name="result">
				<xsl:choose>
					<xsl:when test="AcceptanceNotification[.='COMP']">COMPLIANT</xsl:when>
					<xsl:otherwise>REFUSED</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<bo_comment>
				<xsl:text>
This is a response to Documentary Credit presentation.
See the attached SWIFT message for all details.

				</xsl:text>
				<!-- 
				<xsl:if test="NominatedConfirmingBankContact">	
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(NominatedConfirmingBankContact, '\n')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:text>
					</xsl:text>
				</xsl:if>

				<xsl:if test="DocumentDispatch">
					<xsl:text>
					
					DISPATCH OF DOCUMENTS:
					</xsl:text>
					<xsl:apply-templates select="DocumentDispatch"/>
					<xsl:text>
					</xsl:text>
				</xsl:if>
				
				<xsl:if test="InstructionsFromTheBank">	
					<xsl:text>
					
					INSTRUCTIONS FROM THE BANK:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(InstructionsFromTheBank, '\n')"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:text>
					</xsl:text>
				</xsl:if>
 				-->
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:text>
					
BANK TO CORPORATE INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="Discrepancies != '' and AcceptanceNotification[.='REFU']">
					<xsl:text>
					
DISCREPANCIES:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="Discrepancies"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>			
			</bo_comment>
			<xsl:if test="FileIdentification">
			 <xsl:apply-templates select="FileIdentification"/> 
			</xsl:if>

		</el_tnx_record>
    </xsl:template> 	 	  
</xsl:stylesheet>