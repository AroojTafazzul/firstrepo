<?xml version="1.0" encoding="UTF-8" ?>
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="service">
				
<xsl:template match="program_counterparty_details">
	<result>
 		<com.misys.portal.systemfeatures.common.ProgramCounterpartyFile>
 			<xsl:apply-templates select="program_counterparty">
 				<xsl:with-param name="operation_type"><xsl:value-of select="./operation_type"/></xsl:with-param>
 			</xsl:apply-templates>
 			<xsl:apply-templates select="static_beneficiary"/>
 		</com.misys.portal.systemfeatures.common.ProgramCounterpartyFile>
	</result>
</xsl:template>
	

	<xsl:template match="program_counterparty">
		<xsl:param name="operation_type"/>
		<xsl:param name="cpty_cust_reference" select='cpty_customer_reference'/>
		<xsl:variable name="references" select="service:retrieveProgramCounterpartyData(//program_code, //abbv_name, //customer_reference, $operation_type,$cpty_cust_reference)"/>
		<com.misys.portal.systemfeatures.common.ProgramCounterparty>
				<program_cpty_id>
					<xsl:value-of select= "$references/references/programCptyId"/>
				</program_cpty_id>
				<program_id>
					<xsl:value-of select="$references/references/programId"/>
				</program_id>
				<beneficiary_id>
					<xsl:value-of select="$references/references/beneficiaryId"/>
				</beneficiary_id>
				<cpty_customer_id>
					<xsl:value-of select="$references/references/cptyCustId"/>
				</cpty_customer_id>
				 <cpty_customer_reference>
						<xsl:value-of select="$references/references/cptyCustReference"/>
				</cpty_customer_reference>
				<xsl:if test="program_code">	
					<program_code>
						<xsl:value-of select="program_code"/>
					</program_code>
				</xsl:if>
				<xsl:if test="prog_cpty_assn_status">
					<prog_cpty_assn_status>
						<xsl:value-of select="prog_cpty_assn_status"/>
					</prog_cpty_assn_status>
				</xsl:if>
				<xsl:if test="bo_status">	
					<bo_status>
						<xsl:value-of select="bo_status"/>
					</bo_status>
				</xsl:if>
				<xsl:if test="limit_cur_code">	
					<limit_cur_code>
						<xsl:value-of select="limit_cur_code"/>
					</limit_cur_code>
				</xsl:if>
				<xsl:if test="limit_amt">		
					<limit_amt>
						<xsl:value-of select="limit_amt"/>
					</limit_amt>
				</xsl:if>	
				<additional_field name="operation_type" type="string" scope="none">
					<xsl:value-of select="$operation_type"/>
				</additional_field>				
			</com.misys.portal.systemfeatures.common.ProgramCounterparty>
	</xsl:template>
	<xsl:template match="static_beneficiary">
		<com.misys.portal.systemfeatures.common.StaticBeneficiary>
			<xsl:if test="beneficiary_id">
				<beneficiary_id>
					<xsl:value-of select="beneficiary_id"/>
				</beneficiary_id>
			</xsl:if>
			<xsl:if test="abbv_name">
				<abbv_name>
					<xsl:value-of select="abbv_name"/>
				</abbv_name>
			</xsl:if>
			<xsl:if test="name">
				<name>
					<xsl:value-of select="name"/>
				</name>
			</xsl:if>
			<xsl:if test="address_line_1">
				<address_line_1>
					<xsl:value-of select="address_line_1"/>
				</address_line_1>
			</xsl:if>
			<xsl:if test="address_line_2">
				<address_line_2>
					<xsl:value-of select="address_line_2"/>
				</address_line_2>
			</xsl:if>
			<xsl:if test="dom">
				<dom>
					<xsl:value-of select="dom"/>
				</dom>
			</xsl:if>
			<xsl:if test="country">
				<country>
					<xsl:value-of select="country"/>
				</country>
			</xsl:if>
			<xsl:if test="contact_name">
				<contact_name>
					<xsl:value-of select="contact_name"/>
				</contact_name>
			</xsl:if>
			<xsl:if test="phone">
				<phone>
					<xsl:value-of select="phone"/>
				</phone>
			</xsl:if>
			<xsl:if test="fax">
				<fax>
					<xsl:value-of select="fax"/>
				</fax>
			</xsl:if>
			<xsl:if test="telex">
				<telex>
					<xsl:value-of select="telex"/>
				</telex>
			</xsl:if>
			<xsl:if test="reference">
				<reference>
					<xsl:value-of select="reference"/>
				</reference>
			</xsl:if>
			<xsl:if test="email">
				<email>
					<xsl:value-of select="email"/>
				</email>
			</xsl:if>
			<xsl:if test="web_address">
				<web_address>
					<xsl:value-of select="web_address"/>
				</web_address>
			</xsl:if>
			<xsl:if test="access_opened">
				<access_opened>
					<xsl:value-of select="access_opened"/>
				</access_opened>
			</xsl:if>
			<xsl:if test="notification_enabled">
				<notification_enabled>
					<xsl:value-of select="notification_enabled"/>
				</notification_enabled>
			</xsl:if>
			<xsl:if test="fscm_enabled">
				<fscm_enabled>
						<xsl:value-of select="fscm_enabled"/>
				</fscm_enabled>
			</xsl:if>
			<xsl:if test="beneficiary_company_abbv_name">
				<beneficiary_company_abbv_name>
					<xsl:value-of select="beneficiary_company_abbv_name"/>
				</beneficiary_company_abbv_name>
			</xsl:if>
			<xsl:if test="brch_code">
				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
			</xsl:if>
			<xsl:if test="entity">
				<entity>
					<xsl:value-of select="entity"/>
				</entity>
			</xsl:if>
			<xsl:if test="owner_customer_abbv_name">
				<additional_field name="owner_customer_abbv_name" type="string" scope="none">
					<xsl:value-of select="owner_customer_abbv_name"/>
				</additional_field>
			</xsl:if>
			<xsl:apply-templates select="additional_field"/>
		</com.misys.portal.systemfeatures.common.StaticBeneficiary>
	</xsl:template>
</xsl:stylesheet>
