<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:param name="parm_id"/>

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process Alerts -->
	<xsl:template match="boreference_record">
		<xsl:param name="bank_abbv_name">
			<xsl:value-of select="bank_abbv_name"/>
		</xsl:param>
		<xsl:param name="abbv_name">
			<xsl:value-of select="abbv_name"/>
		</xsl:param>
			<xsl:call-template name="bo_reference">
				<xsl:with-param name="bank_abbv_name">
					<xsl:value-of select="$bank_abbv_name"/>
				</xsl:with-param>
				<xsl:with-param name="abbv_name">
					<xsl:value-of select="$abbv_name"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Alert References -->
	<xsl:template name="bo_reference">
		<xsl:param name="bank_abbv_name"/>
		<xsl:param name="abbv_name"/>
		<xsl:for-each select="//*[starts-with(name(), 'bo_reference')]">
			<!-- 
			<xsl:variable name="entitycode">
				<xsl:choose>
					<xsl:when test="entitycode != ''"><xsl:value-of select="entitycode"/></xsl:when>
					<xsl:otherwise>*</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			-->
			<xsl:variable name="customer_input_center">
				<xsl:value-of select="customer_input_center"/>
			</xsl:variable>
			<xsl:variable name="cust_reference">
				<xsl:value-of select="cust_reference"/>
			</xsl:variable>
			<xsl:variable name="back_office_1">
				<xsl:value-of select="back_office_1"/>
			</xsl:variable>
			<xsl:variable name="prodcode">
				<xsl:value-of select="prodcode"/>
			</xsl:variable>
			<xsl:variable name="subprodcode">
				<xsl:value-of select="subprodcode"/>
			</xsl:variable>
			 <xsl:variable name="from">
				<xsl:value-of select="from"/>
			</xsl:variable>
			<xsl:variable name="to">
				<xsl:value-of select="to"/>
			</xsl:variable>
			<xsl:variable name="title">
				<xsl:value-of select="title"/>
			</xsl:variable>
			<xsl:variable name="uniqueRef">
				<xsl:value-of select="uniqueRef"/>
			</xsl:variable>	
			<parameter_data>
				<xsl:element name="parm_id">
					<xsl:value-of select="$parm_id"/>
				</xsl:element>
				<xsl:element name="key_1">
					<xsl:value-of select="$bank_abbv_name"/>
				</xsl:element>
				<!-- 
				<xsl:element name="key_2">
					<xsl:value-of select="$entitycode"/>
				</xsl:element>
				-->
				<xsl:element name="key_3">
					<xsl:value-of select="$prodcode"/>
				</xsl:element>
				<xsl:element name="key_4"><xsl:if test="$from != ''"><xsl:value-of select="$from"/></xsl:if><xsl:if test="$from = ''">**</xsl:if></xsl:element>
				<xsl:element name="key_5"><xsl:if test="$to != ''"><xsl:value-of select="$to"/></xsl:if><xsl:if test="$to = ''">**</xsl:if></xsl:element>
				<xsl:element name="key_6"><xsl:value-of select="$uniqueRef"/></xsl:element>
				<xsl:element name="key_7"><xsl:if test="$title != ''"><xsl:value-of select="$title"/></xsl:if><xsl:if test="$title = ''">**</xsl:if></xsl:element>
				<xsl:element name="key_8"><xsl:if test="$customer_input_center != ''"><xsl:value-of select="$customer_input_center"/></xsl:if><xsl:if test="$customer_input_center = ''">**</xsl:if></xsl:element>
				<xsl:element name="key_9"><xsl:value-of select="$cust_reference"/></xsl:element>
				<xsl:element name="key_10"><xsl:if test="$back_office_1 != ''"><xsl:value-of select="$back_office_1"/></xsl:if><xsl:if test="$back_office_1 = ''">**</xsl:if></xsl:element>
				<xsl:element name="key_11"><xsl:if test="$subprodcode != ''"><xsl:value-of select="$subprodcode"/></xsl:if><xsl:if test="$subprodcode = ''">**</xsl:if></xsl:element>
			</parameter_data>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
