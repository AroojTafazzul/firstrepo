<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"		
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
		exclude-result-prefixes="localization service utils">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<743/767> (Advice of Amended Guarantee) into br_tnx_record or si_tnx_record
	MT767 is used for both products. We use the XML tag value RelatedReference that should contains
	our reference id and thus the product code.
	 -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/>
   <xsl:param name="language">en</xsl:param>
   <!-- reference should be equal to CustomerReferenceNumber in the message --> 
   <!--  
   <xsl:param name="product_code"><xsl:value-of select="substring($reference,1,2)"/></xsl:param>       
   -->
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT767']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT767']">		 		
    	<xsl:variable name="productCode" select="service:detectProductCodeFromBoRefId($reference, 'BR,SI')"/>
    	<!--  
    	<xsl:variable name="tnxid"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/GuaranteeNumber"/></xsl:variable>
    	<xsl:variable name="refid"><xsl:value-of select="service:retrieveRefIdFromTnxId($tnxid, $productCode)"/></xsl:variable>
    	-->
    	<xsl:variable name="lowercase_product_code">
    		<xsl:value-of select="translate($productCode, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
    	</xsl:variable>
    	<xsl:variable name="root_node"><xsl:value-of select="$lowercase_product_code"/>_tnx_record</xsl:variable>
		<xsl:element name="{$root_node}">
			 <xsl:attribute name="xsi:noNamespaceSchemaLocation">
			 	<xsl:choose>
			 		<xsl:when test="$lowercase_product_code = 'br'">http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'si'">http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd</xsl:when>			 		
			 	</xsl:choose>
    		</xsl:attribute>
        <!--  <ref_id><xsl:value-of select="$refid"/></ref_id> -->
        <brch_code>00001</brch_code>
        <bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/BankReferenceNumber"/></bo_ref_id>
		<!--  <tnx_id><xsl:value-of select="$tnxid"/></tnx_id> -->
		<tnx_type_code>03</tnx_type_code>
		<sub_tnx_type_code>02</sub_tnx_type_code>
		<prod_stat_code>08</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>  
		<product_code><xsl:value-of select="translate($productCode, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></product_code>	
		
		<iss_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT743']/DateOfIssue"/></xsl:call-template></iss_date>
		
		<xsl:variable name="ExtractedDate">
			<xsl:call-template name="extract_exp_date">
				<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT767']/AmendmentDetails"/>
				<xsl:with-param name="prefix">EXPDT/</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:if test="$ExtractedDate != ''">
			<exp_date>
					<xsl:call-template name="format_date"><xsl:with-param name="input_date" select="$ExtractedDate"/></xsl:call-template>
			</exp_date>
		</xsl:if>
				
		<xsl:if test="DateOfIssueOrRequestToIssue">
		  <amd_date><xsl:apply-templates select="DateOfIssueOrRequestToIssue"/></amd_date>
		</xsl:if>
		
		<xsl:variable name="ExtractedAmount">
			<xsl:call-template name="extract_amount">
				<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT767']/AmendmentDetails"/>
				<xsl:with-param name="prefix">TRNAMT/</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="amount">
			<xsl:call-template name="format_amount">
				<xsl:with-param name="amount"><xsl:value-of select="substring($ExtractedAmount,4)"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param>
			</xsl:call-template>		
		</xsl:variable>		
		<tnx_cur_code><xsl:value-of select="substring($ExtractedAmount,1,3)"/></tnx_cur_code>			  	
      	<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
      	
      	<!-- <bg_cur_code><xsl:value-of select="substring($ExtractedAmount,1,3)"/></bgc_cur_code>			  	
      	<bg_amt><xsl:value-of select="$amount"/></bg_amt> -->
      	
		<xsl:variable name="beneficiaryreference">
			<xsl:call-template name="extract_customer_reference">
				<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT743']/BankToCorporateInformation"/>
				<xsl:with-param name="prefix">CUST/</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>		
	    <beneficiary_reference>
			<xsl:value-of select="$beneficiaryreference"></xsl:value-of>
		</beneficiary_reference>
		
		<xsl:if test="$lowercase_product_code = 'br'">
		  <contract_ref>
		    <xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/GuaranteeNumber"/>
		  </contract_ref>
		</xsl:if>
			
		<issuing_bank>
			<xsl:variable name="sender_address_bic">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/IssuingGuarantorBankA"/>
			</xsl:variable>
			<xsl:variable name="sender">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/IssuingGuarantorBankD"/>
			</xsl:variable>
			<xsl:variable name="backslashn">\n</xsl:variable>
			<xsl:variable name="sendername">
				<xsl:choose>
					<xsl:when test="contains($sender,$backslashn)">
						<xsl:value-of select="substring-before($sender, $backslashn)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$sender"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="senderadd1">
				<xsl:choose>
					<xsl:when test="contains(substring-after($sender, $backslashn),$backslashn)">
						<xsl:value-of select="substring-before(substring-after($sender, $backslashn), $backslashn)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-after($sender, $backslashn)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="senderadd2">
				<xsl:choose>
					<xsl:when test="contains(substring-after(substring-after($sender, $backslashn), $backslashn),$backslashn)">
						<xsl:value-of select="substring-before(substring-after(substring-after($sender, $backslashn), $backslashn), $backslashn)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-after(substring-after($sender, $backslashn), $backslashn)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<abbv_name></abbv_name>
			<xsl:variable name="sender_address_bic">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/IssuingGuarantorBankA"/>
			</xsl:variable>
			<name><xsl:value-of select="$sendername"/></name>
			<address_line_1><xsl:value-of select="$senderadd1"/></address_line_1>
			<address_line_2><xsl:value-of select="$senderadd2"/></address_line_2>
			<dom/>
			<xsl:if test="$lowercase_product_code = 'br'">
			  <reference>
			    <xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/GuaranteeNumber"/>
			  </reference>
			</xsl:if>
			<country><xsl:value-of select="substring($sender_address_bic,5,2)"/></country>
			<iso_code><xsl:value-of select="$sender_address_bic"/></iso_code>
		</issuing_bank>	

		<!-- ADVISING BANK -->	
		<advising_bank>
			<xsl:variable name="advise">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/AdvisingConfirmingBankD"/>
			</xsl:variable>
			<xsl:variable name="backslashn">\n</xsl:variable>
			<xsl:variable name="advisename">
				<xsl:choose>
					<xsl:when test="contains($advise,$backslashn)">
						<xsl:value-of select="substring-before($advise, $backslashn)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$advise"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="adviseadd1">
				<xsl:choose>
					<xsl:when test="contains(substring-after($advise, $backslashn),$backslashn)">
						<xsl:value-of select="substring-before(substring-after($advise, $backslashn), $backslashn)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-after($advise, $backslashn)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="adviseadd2">
				<xsl:choose>
					<xsl:when test="contains(substring-after(substring-after($advise, $backslashn), $backslashn),$backslashn)">
						<xsl:value-of select="substring-before(substring-after(substring-after($advise, $backslashn), $backslashn), $backslashn)"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-after(substring-after($advise, $backslashn), $backslashn)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:variable name="bank" select="utils:getBankFromCustomerReference($beneficiaryreference)"/>
			<abbv_name><xsl:value-of select="$bank"/></abbv_name>
			<name><xsl:value-of select="$advisename"/></name>
			<address_line_1><xsl:value-of select="$adviseadd1"/></address_line_1>
			<address_line_2><xsl:value-of select="$adviseadd2"/></address_line_2>
			<dom/>
			<xsl:variable name="bankA_bic">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/AdvisingConfirmingBankA"/>				
			</xsl:variable>
			<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		</advising_bank>
	    				      	
		<bo_comment>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT743']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT743']/BankToCorporateInformation != ''">
				<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
					<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT743']/BankToCorporateInformation, '\n')"/>
				</xsl:with-param>
				</xsl:call-template><xsl:text>
				</xsl:text>
			</xsl:if>						
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT743']/InstructionsFromTheBank and ../MeridianMessage[ExternalMessageType = 'MT743']/InstructionsFromTheBank != ''">
				<xsl:call-template name="backslashn_replace">
				<xsl:with-param name="input_text">
					<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT743']/InstructionsFromTheBank"/>
				</xsl:with-param>
				</xsl:call-template>
			</xsl:if>				
		</bo_comment>
		<amd_details>
			<xsl:apply-templates select="AmendmentDetails"/>
		</amd_details>
		<!-- If 23X is there then call the below line -->
		<xsl:apply-templates select="FileIdentification"/>					
      </xsl:element>
    </xsl:template>
    
    <xsl:template match="AmendmentDetails">		
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>	
	</xsl:template>
			
	<xsl:template match="DateOfIssueOrRequestToIssue">
		<xsl:call-template name="format_date"><xsl:with-param name="input_date" select="."/></xsl:call-template>	
	</xsl:template>	    
</xsl:stylesheet>