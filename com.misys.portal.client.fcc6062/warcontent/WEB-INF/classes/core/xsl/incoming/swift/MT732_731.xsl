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
	<!-- Transform MT798<731/732> (Notification of Advice of Discharge) into lc_tnx_record or el_tnx_record -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/> 
	<xsl:param name="language">en</xsl:param>

	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT731']/DocCreditNo, 'LC,EL')"/>
		<xsl:choose>
			<xsl:when test="$productCode='LC'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT731']" mode="LC"/></xsl:when>
			<xsl:when test="$productCode='EL'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT732']" mode="EL"/></xsl:when>
	    </xsl:choose>
	</xsl:template>

    <xsl:template match="MeridianMessage" mode="LC">
     	<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(../MeridianMessage[ExternalMessageType = 'MT732']/SenderTRN, 'LC')"/>
   		    
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT732']/SenderTRN"/></bo_ref_id>
			<xsl:if test="CustomerReferenceNumber">
				<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>
			<xsl:if test="DrawingAmount">
				<tnx_cur_code><xsl:value-of select="substring(DrawingAmount,1,3)"/></tnx_cur_code>
				<!-- Credit amount -->
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(DrawingAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
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
				<doc_ref_no>
					<xsl:value-of select="BankReferenceNumber"/>
				</doc_ref_no>
			</xsl:if>

			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/PresentationReferenceNumber">
				<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/PresentationReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			
			<xsl:if test="AdditionalCustomerReference">
				<cust_ref_id><xsl:value-of select="AdditionalCustomerReference"/></cust_ref_id>
			</xsl:if>
			<xsl:if test="CreditAmount">
				<lc_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></lc_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<lc_amt><xsl:value-of select="$amount"/></lc_amt>
			</xsl:if>
			
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:if test="IssueDate">
				<iss_date><xsl:value-of select="IssueDate"/></iss_date>
			</xsl:if>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/IssuingBankA"/>
		    <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/IssuingBankD"/>
		    <xsl:if test="IssuingBankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="IssuingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			 <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/NominatedConfirmingBankA"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/NominatedConfirmingBankD"/>
			<xsl:text>
			NOMINATED/CONFIRMING BANK CONTACT:
			</xsl:text>				
			<xsl:if test="NominatedConfirmingBankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="NominatedConfirmingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>	
			<xsl:if test="FileIdentification">
			 <xsl:apply-templates select="FileIdentification"/> 
			</xsl:if>
			<bo_comment>
				<xsl:text>
				This is a notification of advise of Discharge.
				See the attached SWIFT message for all details.
				</xsl:text>

				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT732']/SenderReceiverInf != ''">
					<xsl:text>
					
SEND TO RECEIVER INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT732']/SenderReceiverInf"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/BankToCorporateInformation != ''">
				<xsl:text>

BANK TO CORPORATE INFO:
				
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/InstructionsFromBank != ''">
				<xsl:text>

INSTRUCTIONS FROM BANK:
				
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/InstructionsFromBank"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				
			</bo_comment>
			<!-- <xsl:apply-templates select="FileIdentification"/> -->
		</lc_tnx_record>
    </xsl:template>

	<xsl:template match="MeridianMessage" mode="EL">
		<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(../MeridianMessage[ExternalMessageType = 'MT732']/SenderTRN, 'EL')"/>
		
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
	        <brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT732']/SenderTRN"/></bo_ref_id>
			<xsl:if test="CustomerReferenceNumber">
				<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT731']/DrawingAmount,4)"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>
			</xsl:variable>
			<tnx_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT731']/DrawingAmount,1,3)"/></tnx_cur_code>
	      	<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			<beneficiary_reference>
				<xsl:choose>
					<xsl:when test="$cust-reference-enabled = 'true'">
						<xsl:call-template name="extract_customer_reference">
							<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT731']/BankToCorporateInformation"/>
							<xsl:with-param name="prefix">CUST/</xsl:with-param>
						</xsl:call-template>					
					</xsl:when>
					<xsl:when test="$cust-reference-enabled = 'false'">
						<xsl:value-of select="$cust-reference"/>	
					</xsl:when>
				</xsl:choose>
			</beneficiary_reference>
			<xsl:if test="BankReferenceNumber">
				<doc_ref_no>
					<xsl:value-of select="BankReferenceNumber"/>
				</doc_ref_no>
			</xsl:if>
			
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/PresentationReferenceNumber">
				<bo_tnx_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/PresentationReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/AdditionalCustomerReference">
				<cust_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/AdditionalCustomerReference"/></cust_ref_id>
			</xsl:if>
			<xsl:if test="CreditAmount">
				<lc_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></lc_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<lc_amt><xsl:value-of select="$amount"/></lc_amt>
			</xsl:if>
			
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:if test="IssueDate">
				<iss_date><xsl:value-of select="IssueDate"/></iss_date>
			</xsl:if>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/IssuingBankA"/>
		    <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/IssuingBankD"/>
		     <xsl:if test="IssuingBankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="IssuingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			 <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/NominatedConfirmingBankA"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/NominatedConfirmingBankD"/>
			<xsl:text>
			NOMINATED/CONFIRMING BANK CONTACT:
			</xsl:text>				
			<xsl:if test="NominatedConfirmingBankContact != ''">
			<xsl:call-template name="backslashn_replace">
			<xsl:with-param name="input_text">
				<xsl:value-of select="NominatedConfirmingBankContact"/>
			</xsl:with-param>
			</xsl:call-template><xsl:text>
			</xsl:text>
			</xsl:if>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/FileIdentification"/>
			<bo_comment>
				<xsl:text>
				This is a notification of advise of Discharge.
				See the attached SWIFT message for all details.
				</xsl:text>
				
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/BankToCorporateInformation != ''">
				<xsl:text>

BANK TO CORPORATE INFO:
				
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT731']/InstructionsFromBank != ''">
				<xsl:text>

INSTRUCTIONS FROM BANK:
				
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT731']/InstructionsFromBank"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				</bo_comment>			
			<!-- <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT731']/FileIdentification"/> -->
		</el_tnx_record>
    </xsl:template>
    
</xsl:stylesheet>