<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	exclude-result-prefixes="tools">

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<!-- Get the interface environment -->
	<xsl:param name="context"/>
	<xsl:param name="language">en</xsl:param>
	
	<!--
	Copyright (c) 2000-2010 Misys (http://www.misys.com),
	All Rights Reserved. 
	-->

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates select="reference_record"/>
	</xsl:template>
	
	<xsl:template match="reference_record">
		<Message>
		    <Header>
		        <MsgType>CUSDISREQ</MsgType>
		        <MsgID>
		            <IFMid><xsl:value-of select="tools:generateCustomerReferenceMhubId()" /></IFMid>
		        </MsgID>
		        <Resend>0</Resend>
		    </Header>
		    <Content>
		        <CustEnableDetail>
		            <BMCustNo><xsl:value-of select="reference"/></BMCustNo>
		            <CustomerName><xsl:value-of select="customer_abbv_name"/> </CustomerName>
		            <Note1/>
		            <Note2/>
		            <Print>True</Print>
		        </CustEnableDetail>
		    </Content>
		</Message>
	</xsl:template>
</xsl:stylesheet>




