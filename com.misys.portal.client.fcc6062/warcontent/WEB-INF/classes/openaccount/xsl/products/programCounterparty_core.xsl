<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">
<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:import href='../../../core/xsl/products/beneficiary_save.xsl' />
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- <xsl:apply-templates select="program_counterparties/program_counterparty"/> -->
	
	
	<!-- Process PROGRAM COUNTERPARTY-->
	<xsl:template match = "program_counterparty">
		<result>
			<com.misys.portal.systemfeatures.common.ProgramCounterparty>
				<xsl:attribute name="program_cpty_id"><xsl:value-of select="program_cpty_id"/></xsl:attribute>
				<xsl:if test="program_id">
					<program_id>
						<xsl:value-of select="program_id"/>
					</program_id>
				</xsl:if>
				<xsl:if test="program_code">
					<program_code>
						<xsl:value-of select="program_code"/>
					</program_code>
				</xsl:if>
				<xsl:if test="beneficiary_id">
					<beneficiary_id>
						<xsl:value-of select="beneficiary_id"/>
					</beneficiary_id>
				</xsl:if>
				<xsl:if test="cpty_customer_id">
					<cpty_customer_id>
						<xsl:value-of select="cpty_customer_id"/>
					</cpty_customer_id>
				</xsl:if>
				<xsl:if test="cpty_customer_reference">
					<cpty_customer_reference>
						<xsl:value-of select="cpty_customer_reference"/>
					</cpty_customer_reference>
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
				<!-- additional field added - operation code -->
				<xsl:if test="operation_type">
					<additional_field name="operation_type" type="string" scope="none">
						<xsl:value-of select="operation_type"/>
					</additional_field>
				</xsl:if>
				<xsl:call-template name="product-additional-fields"/>
			</com.misys.portal.systemfeatures.common.ProgramCounterparty>
			<!--Associated counterparties -->
			 <xsl:apply-templates select="associated_counterparties/associated_counterparty">
				<xsl:with-param name="abbv_name"><xsl:value-of select="abbv_name"/></xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="name"/></xsl:with-param>
			</xsl:apply-templates> 
		</result>
	</xsl:template>
	
	 <xsl:template match="associated_counterparties/associated_counterparty">
	 	<xsl:param name="abbv_name"/>
	 	<xsl:param name="name"/>
		<xsl:call-template name="associated_counterparty">
			<xsl:with-param name="abbv_name" select="$abbv_name"/>
			<xsl:with-param name="name" select="$name"/>
		</xsl:call-template>	
	</xsl:template>
	
	<xsl:template name="associated_counterparty">
		<xsl:param name="abbv_name"/>
		<xsl:param name="name"/>
		<com.misys.portal.systemfeatures.common.StaticBeneficiary>
			<!-- <xsl:attribute name="abbv_name"><xsl:value-of select="$abbv_name"/></xsl:attribute>
			<abbv_name><xsl:value-of select="$abbv_name"/></abbv_name> -->			
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
		</com.misys.portal.systemfeatures.common.StaticBeneficiary>
	</xsl:template> 
	 <xsl:template name="product-additional-fields"/>
</xsl:stylesheet>