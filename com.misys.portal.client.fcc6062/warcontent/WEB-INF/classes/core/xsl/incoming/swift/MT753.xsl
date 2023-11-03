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
	<!-- Transform MT798<753/754> (Notification of Advice of Payment/Acceptance/Negotiation) into lc_tnx_record-->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
	<xsl:param name="reference"/> 
	<xsl:param name="language">en</xsl:param>

	<xsl:template match="/">
		<!-- try to find if the bo_ref_id is in the LC or EL tables -->
		<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId(MeridianMessages/MeridianMessage[ExternalMessageType = 'MT753']/DocCreditNo, 'LC,EL')"/>
		<xsl:choose>
			<xsl:when test="$productCode='LC'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT753']" mode="LC"/></xsl:when>
	        <xsl:when test="$productCode='EL'"><xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT753']" mode="EL"/></xsl:when>
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
			<!-- <xsl:if test="CreditAmount">
				<tnx_cur_code><xsl:value-of select="substring(CreditAmount,1,3)"/></tnx_cur_code>
				Credit amount
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount"><xsl:value-of select="substring(CreditAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
			</xsl:if> -->
			<xsl:if test="PresentationReferenceNumber">
			<bo_tnx_id><xsl:value-of select="PresentationReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			<xsl:if test="CustomerReferenceNumber">
			<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<doc_ref_no><xsl:value-of select="BankReferenceNumber"/></doc_ref_no>
			 <xsl:if test="PrincipalAmount">
				<tnx_cur_code><xsl:value-of select="substring(PrincipalAmount,1,3)"/></tnx_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(PrincipalAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>			
			</xsl:if> 
			 
			 <xsl:if test="AdditionalCustomerReference">
			    <cust_ref_id><xsl:value-of select="AdditionalCustomerReference"/></cust_ref_id>
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
			<xsl:if test="MaturityDate != ''">
				<maturity_date>
					<xsl:call-template name="format_date">
						<xsl:with-param name="input_date" select="MaturityDate"/>
					</xsl:call-template>
				</maturity_date>
			</xsl:if>
			<bo_comment>
				<xsl:text>
				This is a notification of advise of Payment/Acceptance/Negotiation.
				See the attached SWIFT message for all details.
				</xsl:text>
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT753']/SenderToReceiverInfo != ''">
					<xsl:text>
					
					SEND TO RECEIVER INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT753']/SenderToReceiverInfo"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:text>
	
					BANK TO CORPORATE INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="BankToCorporateInformation"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>
			</bo_comment>
			<xsl:apply-templates select="DateOfIssue"/>
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:apply-templates select="FileIdentification"/> 
			<xsl:apply-templates select="IssuingBankA"/>
		    <xsl:apply-templates select="IssuingBankD"/>
		    <xsl:apply-templates select="NominatedConfirmingBankA"/>
			<xsl:apply-templates select="NominatedConfirmingBankD"/>
		</lc_tnx_record>
    </xsl:template>
   
   
    	<xsl:template match="MeridianMessage" mode="EL">
    	
    	<xsl:variable name="cust-reference-enabled">
    		<xsl:value-of select="defaultresource:getResource('USE_72C_IN_MT798_FOR_CUSTREF')"/>
        </xsl:variable>
   		<xsl:variable name="cust-reference" select="service:retrieveCustomerReferenceFromBoRefId(DocCreditNo, 'EL')"/>
  
		<el_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/el.xsd">
			<brch_code>00001</brch_code>       
			<!-- <lc_ref_id><xsl:value-of select="RelatedRef"/></lc_ref_id>  -->        
			<bo_ref_id><xsl:value-of select="DocCreditNo"/></bo_ref_id>
			<tnx_type_code>15</tnx_type_code>
			<sub_tnx_type_code/>
			<prod_stat_code>07</prod_stat_code>
			<tnx_stat_code>04</tnx_stat_code>
			<product_code>EL</product_code>
			<xsl:choose>
				<xsl:when test="PrincipalAmountA">
					<tnx_cur_code><xsl:value-of select="substring(PrincipalAmountA,7,3)"/></tnx_cur_code>
					Credit amount
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(PrincipalAmountA,10)"/></xsl:with-param>
						</xsl:call-template>		
					</xsl:variable>
					<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
					<maturity_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="normalize-space(PrincipalAmountA)"/></xsl:call-template></maturity_date>
				</xsl:when>
				<xsl:when test="PrincipalAmountB">
					<tnx_cur_code><xsl:value-of select="substring(PrincipalAmountB,1,3)"/></tnx_cur_code>
					Credit amount
					<xsl:variable name="amount">
						<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(PrincipalAmountB,4)"/></xsl:with-param>
						</xsl:call-template>		
					</xsl:variable>
					<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>			
				</xsl:when>
			</xsl:choose>	
			 <xsl:if test="PrincipalAmount">
				<tnx_cur_code><xsl:value-of select="substring(PrincipalAmount,1,3)"/></tnx_cur_code>
				<xsl:variable name="amount">
					<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(PrincipalAmount,4)"/></xsl:with-param>
					</xsl:call-template>		
				</xsl:variable>
				<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>			
			</xsl:if> 
			<xsl:if test="PresentationReferenceNumber">
			<bo_tnx_id><xsl:value-of select="PresentationReferenceNumber"/></bo_tnx_id>
			</xsl:if>
			<xsl:if test="CustomerReferenceNumber">
			<ref_id><xsl:value-of select="CustomerReferenceNumber"/></ref_id>
			</xsl:if>
			<doc_ref_no><xsl:value-of select="BankReferenceNumber"/></doc_ref_no>
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
			<xsl:if test="MaturityDate != ''">  	
			 <maturity_date>
			  <xsl:call-template name="format_date">
			   <xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT753']/MaturityDate"/>
			  </xsl:call-template>
			 </maturity_date> 
			</xsl:if>     	
			<bo_comment>
				<xsl:text>
				This is a Notification of Advice of Payment/Acceptance/Negotiation.
				See the attached SWIFT message for all details.
				</xsl:text>	
				<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT753']/SenderToReceiverInfo != ''">
					<xsl:text>
					
					SEND TO RECEIVER INFO:
					</xsl:text>
					<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT753']/SenderToReceiverInfo"/>
						</xsl:with-param>
					</xsl:call-template><xsl:text>
					</xsl:text>
				</xsl:if>		
				<xsl:if test="BankToCorporateInformation != ''">
					<xsl:text>
		
						BANK TO CORPORATE INFO:
					</xsl:text>
				<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
					<xsl:value-of select="BankToCorporateInformation"/>
				</xsl:with-param>
				</xsl:call-template><xsl:text>
				</xsl:text>
				</xsl:if>		
			</bo_comment>
				
			<xsl:apply-templates select="DateOfIssue"/>	
			<xsl:if test="CreationDateTime">
				<xsl:apply-templates select="CreationDateTime"/>
			</xsl:if>
			<xsl:apply-templates select="IssuingBankA"/>
		    <xsl:apply-templates select="IssuingBankD"/>
		    <xsl:apply-templates select="NominatedConfirmingBankA"/>
			<xsl:apply-templates select="NominatedConfirmingBankD"/>	
			<xsl:apply-templates select="../MeridianMessage[ExternalMessageType = 'MT753']/FileIdentification"/>
		</el_tnx_record>
    </xsl:template>

   
</xsl:stylesheet>