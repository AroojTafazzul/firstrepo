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
	<!-- Transform MT798<733/734> (Notification of Advice of Refusal) into lc_tnx_record or el_tnx_record -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/>
	<xsl:param name="language">en</xsl:param>

	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT733']/DocCreditNo, 'LC,EL')"/>
		<xsl:choose>
			<xsl:when test="$productCode='LC'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT733']" mode="LC"/></xsl:when>
			<xsl:when test="$productCode='EL'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT733']" mode="EL"/></xsl:when>
	    </xsl:choose>
	</xsl:template>
	
    <xsl:template match="MeridianMessage" mode="LC">    			
    	<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
    	</xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'LC')"/>
     	
		<lc_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/lc.xsd">
			<brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>LC</product_code>

			<!-- Credit amount (?? do something with it ??)-->
			
			<xsl:if test="CreditAmount">
				<tnx_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></tnx_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if>
			
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA">
				<claim_present_date><xsl:call-template name="format_date"><xsl:with-param name="input_date"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA,1,6)"/></xsl:with-param></xsl:call-template></claim_present_date>
					<tnx_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA,7,3)"/></tnx_cur_code>
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA,10)"/></xsl:with-param>
						</xsl:call-template>		
					</xsl:variable>
					<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
				</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedB">
					<tnx_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedB,1,3)"/></tnx_cur_code>
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedB,4)"/></xsl:with-param>
						</xsl:call-template>		
					</xsl:variable>
					<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>			
				</xsl:when>
			</xsl:choose>

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
 
			<xsl:if test="PresentationReferenceNumber">
				<bo_tnx_id>
					<xsl:value-of select="PresentationReferenceNumber"/>
				</bo_tnx_id>
			</xsl:if>
			
			<xsl:if test="BankReferenceNumber">
				<bo_tnx_id>
					<xsl:value-of select="BankReferenceNumber"/>
				</bo_tnx_id>
			</xsl:if>
			
			<xsl:if test="CustomerReferenceNumber">
				<ref_id>
				   <xsl:value-of select="CustomerReferenceNumber"/>
				</ref_id>
			</xsl:if>
			
			<xsl:apply-templates select="DateOfIssue"/>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/IssuingBankA"/>
		    <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/IssuingBankD"/>
		    <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/NominatedConfirmingBankA"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/NominatedConfirmingBankD"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT734']/ChargesClaimed"/>
	
		
			<bo_comment>
				<xsl:text>
				This is a notification of advice of Refusal.
				See the attached SWIFT message for all details.
				</xsl:text>
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:text>

					BANK TO CORPORATE INFO:
					</xsl:text>
					
					<xsl:choose>
					<xsl:when test="$cust-reference-enabled = 'true'">
						<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT733']/BankToCorporateInformation, '\n')"/>
						</xsl:with-param>
					    </xsl:call-template>				
					</xsl:when>
					<xsl:when test="$cust-reference-enabled = 'false'">
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT733']/BankToCorporateInformation"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/SenderToReceiverInfo != ''">
					<xsl:text>

					SEND TO RECEIVER INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/SenderToReceiverInfo"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/Discrepancies != ''">
					<xsl:text>
					
					DISCREPANCIES:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/Discrepancies"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>		

				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/DisposalOfDocuments != ''">
					<xsl:text>					
					DISPOSAL OF DOCUMENTS:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/DisposalOfDocuments"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT733']/InstructionsFromTheBank != ''">
				<xsl:text>

				INSTRUCTIONS FROM BANK:
				
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT733']/InstructionsFromTheBank"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>	

			</bo_comment>
			 <xsl:if test="../MeridianMessage[ExternalMessageType = 'MT733']/FileIdentification">
			 <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/FileIdentification"/> 
			 </xsl:if>
		</lc_tnx_record>
    </xsl:template>
    
	<xsl:template match="MeridianMessage" mode="EL">
	  <xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
     </xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'EL')"/>
   		
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
	        <brch_code>00001</brch_code>
			<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA">
				    <tnx_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA,7,3)"/></tnx_cur_code>
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedA,10)"/></xsl:with-param>
						</xsl:call-template>		
					</xsl:variable>
					<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
				</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedB">
					<tnx_cur_code><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedB,1,3)"/></tnx_cur_code>
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT734']/TotalAmountClaimedB,4)"/></xsl:with-param>
						</xsl:call-template>		
					</xsl:variable>
					<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="CreditAmount">
				<tnx_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></tnx_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if>
			<beneficiary_reference>
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
			</beneficiary_reference>
			
			<xsl:if test="BankReferenceNumber">
				<doc_ref_no>
					<xsl:value-of select="BankReferenceNumber"/>
				</doc_ref_no>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/PresentBankRef">
				<bo_tnx_id>
					<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/PresentBankRef"/>
				</bo_tnx_id>
			</xsl:if>
			
			<xsl:if test="CustomerReferenceNumber">
				<ref_id>
				   <xsl:value-of select="CustomerReferenceNumber"/>
				</ref_id>
			</xsl:if>
			
			<xsl:apply-templates select="DateOfIssue"/>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/IssuingBankA"/>
		    <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/IssuingBankD"/>
		    <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/NominatedConfirmingBankA"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/NominatedConfirmingBankD"/>
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT734']/ChargesClaimed"/>
			
			<bo_comment>
			
				<xsl:text>
				This is a notification of advice of Refusal.
				See the attached SWIFT message for all details.

				BANK TO CORPORATE INFO:
				</xsl:text>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT733']/BankToCorporateInformation != ''">
					<xsl:choose>
					<xsl:when test="$cust-reference-enabled = 'true'">
						<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT733']/BankToCorporateInformation, '\n')"/>
						</xsl:with-param>
					    </xsl:call-template>				
					</xsl:when>
					<xsl:when test="$cust-reference-enabled = 'false'">
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT733']/BankToCorporateInformation"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					</xsl:choose>
				</xsl:if>
				
				<xsl:text>
				
				SEND TO RECEIVER INFO:
				</xsl:text>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/SenderToReceiverInfo">
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/SenderToReceiverInfo"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>

				<xsl:text>
				
				DISCREPANCIES:
				</xsl:text>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/Discrepancies != ''">
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/Discrepancies"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>	
				
				
			 <xsl:if test="../MeridianMessage[ExternalMessageType = 'MT734']/DisposalOfDocuments != ''">
				<xsl:text>
									
				DISPOSAL OF DOCUMENTS:
				</xsl:text>
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT734']/DisposalOfDocuments"/>
					</xsl:with-param>
				</xsl:call-template><xsl:text>
				</xsl:text>
			</xsl:if>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT733']/InstructionsFromTheBank != ''">
				<xsl:text>

				INSTRUCTIONS FROM BANK:
				
				</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT733']/InstructionsFromTheBank"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>		

			</bo_comment>	
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT733']/FileIdentification">		
			  <xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT733']/FileIdentification"/> 
		    </xsl:if>
		</el_tnx_record>
    </xsl:template>

</xsl:stylesheet>