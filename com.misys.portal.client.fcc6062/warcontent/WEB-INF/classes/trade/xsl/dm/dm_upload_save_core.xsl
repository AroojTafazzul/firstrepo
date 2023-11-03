<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:encryption="xalan://com.misys.portal.common.security.sso.Cypher" 
	exclude-result-prefixes="converttools encryption">

	<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>

	<xsl:output method="xml" indent="no"/>
	
	<!-- Get the language code -->
	<xsl:param name="language"/>
	

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Process Document Preparation-->
	<xsl:template match="document_tnx_record">
		<result>
			<com.misys.portal.product.dm.common.DocumentInstance>
					<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
					<xsl:attribute name="document_id"><xsl:value-of select="document_id"/></xsl:attribute>

					<brch_code><xsl:value-of select="brch_code"/></brch_code>
					<company_id><xsl:value-of select="company_id"/></company_id>
					<!-- The tnx id is specific to the document -->
					<description><xsl:value-of select="description"/></description>
					<code><xsl:value-of select="code"/></code>
					<title><xsl:value-of select="title"/></title>
					<type><xsl:value-of select="type"/></type>
					<xsl:if test="file_name">
						<additional_field name="file_name" type="string" scope="none"><xsl:value-of select="file_name"/></additional_field>
					</xsl:if>
					<xsl:if test="dtd_code">
						<dtd_code><xsl:value-of select="dtd_code"/></dtd_code>
					</xsl:if>
					<xsl:if test="format">
						<format><xsl:value-of select="format"/></format>
					</xsl:if>
					<version><xsl:value-of select="version"/></version>
					<cust_ref_id><xsl:value-of select="cust_ref_id"/></cust_ref_id>
			</com.misys.portal.product.dm.common.DocumentInstance>
		</result>
	</xsl:template>
	
</xsl:stylesheet>
