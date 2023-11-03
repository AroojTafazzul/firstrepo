<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="default tools localization">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<!-- <xsl:param name="context"/>-->
	<xsl:param name="language"/>
	<xsl:param name="BIC"/>
	
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="Document">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Process TSU Message -->
	<xsl:template match="Ack">
		<!-- Acknowledgement can be related to several types of messages:
			 InitialBaselineSubmission, StatusExtensionRequest, StatusChangeRequest, etc -->
		<xsl:variable name="doesPOExist"><xsl:value-of select="tools:retrieveFieldValueFromProduct('PO', UsrTxRef/Id, 'ref_id')"/></xsl:variable>
		
		<xsl:if test="$doesPOExist != '' and $BIC = UsrTxRef/IdIssr/BIC">
		
		<xsl:variable name="referencedMessageType"><xsl:value-of select="tools:getTSUMessageInfo(AckdMsgRef/Id, 'message_type')"/></xsl:variable>
		<xsl:variable name="transactionType"><xsl:value-of select="tools:getTSUMessageInfo(AckdMsgRef/Id, 'role')"/></xsl:variable>
		<xsl:choose>
			<!-- If Acknowledgement is related to an InitialBaselineSubmission,
				process only if bank is the same as the one who submitted the baseline -->
			<!-- <xsl:when test="$referencedMessageType = '019' and $BIC = UsrTxRef/IdIssr/BIC">-->
			<!-- If Acknowledgement is related to an InitialBaselineSubmission,
				process only if the transaction is Lodge -->
			<xsl:when test="$referencedMessageType = '019'">
				<po_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/po.xsd">
					<brch_code>00001</brch_code>
					<ref_id><xsl:value-of select="UsrTxRef/Id"/></ref_id>
					<company_name><xsl:value-of select="tools:retrieveFieldValueFromProduct('PO', UsrTxRef/Id, 'company_name')"/></company_name>
					<tnx_type_code>15</tnx_type_code>
					<sub_tnx_type_code/>
					<!-- Product status code -->
					<xsl:choose>
						<xsl:when test="TxSts/Sts = 'ESTD'">
							<prod_stat_code>72</prod_stat_code>
						</xsl:when>
						<xsl:when test="TxSts/Sts = 'PROP'">
							<prod_stat_code>83</prod_stat_code>
						</xsl:when>
					</xsl:choose>
					<tnx_stat_code>04</tnx_stat_code>
					<product_code>PO</product_code>
					<tid><xsl:value-of select="TxId/Id"/></tid>
					<additional_field name="hasLineItem" type="string" scope="none">N</additional_field>
					<issuing_bank>
						<abbv_name><xsl:value-of select="tools:retrieveBankAbbvNameFromBICCode($BIC)"/></abbv_name>
						<iso_code><xsl:value-of select="$BIC"/></iso_code>
					</issuing_bank>
					<bo_comment>
					<xsl:choose>
						<xsl:when test="TxSts/Sts = 'ESTD'">
							<xsl:value-of select="localization:getGTPString($language, 'INTERFACE_PO_ESTABLISHED')"/>
						</xsl:when>
						<xsl:when test="TxSts/Sts = 'PROP'">
							<xsl:value-of select="localization:getGTPString($language, 'INTERFACE_PO_PROPOSED')"/>
						</xsl:when>
					</xsl:choose>
					</bo_comment>
				</po_tnx_record>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		
		</xsl:if>
		
	</xsl:template>
</xsl:stylesheet>
