<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"		
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"	
		exclude-result-prefixes="localization utils">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<745/760> Advice of Issued Guarantee. -->
	<!-- Import common functions -->	
	<xsl:import href="MTXXX_common.xsl"/>
    <xsl:param name="reference"/> 
    <xsl:param name="language">en</xsl:param>  
	<xsl:param name="product_code">BR</xsl:param> 
     
  
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT760']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT760']">
    
   <br_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd">
        <brch_code>00001</brch_code>       
         
        <!-- $reference should have the same value as DocCreditNo -->
       	<bo_ref_id><xsl:value-of select="$reference"/></bo_ref_id>
		<!--  <adv_send_mode>01</adv_send_mode> -->
		<tnx_type_code>01</tnx_type_code>
		<sub_tnx_type_code/>		
		<prod_stat_code>03</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>
		<product_code><xsl:value-of select="$product_code"/></product_code>
		<iss_date><xsl:call-template name="format_date"><xsl:with-param name="input_date" select="../MeridianMessage[ExternalMessageType = 'MT745']/DateOfIssue"/></xsl:call-template></iss_date>
		<exp_date_type_code>02</exp_date_type_code>
		<xsl:variable name="ExtractedDate">
			<xsl:call-template name="extract_exp_date">
				<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT760']/DetailsOfGuarantee"/>
				<xsl:with-param name="prefix">EXPDT/</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<exp_date>
			<xsl:if test="$ExtractedDate != ''">
				<xsl:call-template name="format_date"><xsl:with-param name="input_date" select="$ExtractedDate"/></xsl:call-template>
			</xsl:if>
		</exp_date>
		
		<xsl:variable name="ExtractedAmount">
			<xsl:call-template name="extract_amount">
				<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT760']/DetailsOfGuarantee"/>
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
      	
      	<bg_cur_code><xsl:value-of select="substring($ExtractedAmount,1,3)"/></bg_cur_code>			  	
      	<bg_amt><xsl:value-of select="$amount"/></bg_amt>
		<bg_liab_amt><xsl:value-of select="$amount"/></bg_liab_amt>	
		
		<bg_type_code>99</bg_type_code>		
			
		<xsl:call-template name="BGRule">
			<xsl:with-param name="input"><xsl:value-of select="ApplicableRules"/></xsl:with-param>
		</xsl:call-template>	
				   
	    <xsl:variable name="beneficiaryreference">
			<xsl:call-template name="extract_customer_reference">
				<xsl:with-param name="input" select="../MeridianMessage[ExternalMessageType = 'MT745']/BankToCorporateInformation"/>
				<xsl:with-param name="prefix">CUST/</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>		
	    <beneficiary_reference>
			<xsl:value-of select="$beneficiaryreference"></xsl:value-of>
		</beneficiary_reference>
		
		<!-- APPLICANT -->		
		  
		<applicant_name>
		   	<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">1</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/Applicant"/></xsl:with-param>
			</xsl:call-template>
		</applicant_name>
		<applicant_address_line_1>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">2</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/Applicant"/></xsl:with-param>
			</xsl:call-template>
		</applicant_address_line_1>
		<applicant_address_line_2>
			<xsl:call-template name="extract_line">
				<xsl:with-param name="line_number">3</xsl:with-param>
				<xsl:with-param name="input_text"><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/Applicant"/></xsl:with-param>
			</xsl:call-template>
		</applicant_address_line_2>			
		<applicant_reference/>	
		
		<contract_ref><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/GuaranteeNumber"/></contract_ref>
		
		<!-- ISSUING BANK -->
		<issuing_bank>
			<xsl:variable name="sender_address_bic">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/IssuingGuarantorBankA"/>
			</xsl:variable>
			<xsl:variable name="sender">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/IssuingGuarantorBankD"/>
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
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/IssuingGuarantorBankA"/>
			</xsl:variable>
			<name><xsl:value-of select="$sendername"/></name>
			<address_line_1><xsl:value-of select="$senderadd1"/></address_line_1>
			<address_line_2><xsl:value-of select="$senderadd2"/></address_line_2>
			<dom/>
			<reference><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/GuaranteeNumber"/></reference>
			<country><xsl:value-of select="substring($sender_address_bic,5,2)"/></country>
			<iso_code><xsl:value-of select="$sender_address_bic"/></iso_code>
		</issuing_bank>	
		
		<!-- ADVISE THRU BANK -->		
		<advising_bank>
			<xsl:variable name="advise">
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/AdvisingConfirmingBankD"/>
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
				<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/AdvisingConfirmingBankA"/>				
			</xsl:variable>
			<iso_code><xsl:value-of select="$bankA_bic"/></iso_code>
		</advising_bank>
				
		<!-- NARRATIVES -->	
		<narrative_additional_instructions>
			<xsl:apply-templates select="DetailsOfGuarantee[../SequenceOfTotal = '1/1' or ../SequenceOfTotal = '1/2' or ../SequenceOfTotal = '1/3' or ../SequenceOfTotal = '1/4']"/>
			<xsl:apply-templates select="DetailsOfGuarantee[../SequenceOfTotal = '2/2' or ../SequenceOfTotal = '2/3' or ../SequenceOfTotal = '2/4']"/>
			<xsl:apply-templates select="DetailsOfGuarantee[../SequenceOfTotal = '3/3' or ../SequenceOfTotal = '3/4']"/>
			<xsl:apply-templates select="DetailsOfGuarantee[../SequenceOfTotal = '4/4']"/>
		</narrative_additional_instructions>
		<!--  
		<xsl:apply-templates select="SenderToReceiverInformation"/>
		-->
		<bo_comment>
						
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT745']/InstructionsFromTheBank and ../MeridianMessage[ExternalMessageType = 'MT745']/InstructionsFromTheBank != ''">
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/InstructionsFromTheBank"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
						
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT745']/BankToCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT745']/BankToCorporateInformation != ''">
		<xsl:text>
		BANK TO CORPORATE INFO:</xsl:text>
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT745']/BankToCorporateInformation, '\n')"/>
		</xsl:with-param>
		</xsl:call-template><xsl:text>
		</xsl:text>
		</xsl:if>
		
		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT745']/AdvisingBankContact and ../MeridianMessage[ExternalMessageType = 'MT745']/AdvisingBankContact != ''">
		<xsl:text>
		ADVISING BANK CONTACT:</xsl:text>
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text">
			<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT745']/AdvisingBankContact"/>			
		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
							
		</bo_comment>
		
		<!-- If 23X is there then call the below line -->
		<xsl:apply-templates select="FileIdentification"/>		
		</br_tnx_record>
    </xsl:template>
    
    <xsl:template name="BGRule">
    	<xsl:param name="input"/>
    	<bg_rule> 
    	<xsl:choose>
    		<xsl:when test="contains($input, 'ISPR')">11</xsl:when>
    		<xsl:when test="contains($input, 'NONE')">09</xsl:when>
    		<xsl:when test="contains($input, 'OTHR')">99</xsl:when>
    		<xsl:when test="contains($input, 'URDG')">06</xsl:when>
    	</xsl:choose>
    	</bg_rule> 
	</xsl:template>   
</xsl:stylesheet>
