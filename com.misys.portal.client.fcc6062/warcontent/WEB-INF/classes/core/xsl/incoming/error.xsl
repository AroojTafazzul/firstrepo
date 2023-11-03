<?xml version="1.0"?> 
<!--
  		Copyright (c) 2000-2008 Misys (http://www.misys.com)
  		All Rights Reserved. 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="error">
  <xsl:param name="ref_id"/>
  <xsl:param name="tnx_id"/>
  <com.misys.portal.product.common.ProductError>
          	<xsl:attribute name="ref_id"><xsl:value-of select="$ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="$tnx_id"/></xsl:attribute>
 			<xsl:if test="error_code">
				<error_code><xsl:value-of select="error_code"/></error_code>
			</xsl:if>
			<xsl:if test="process">
				<process><xsl:value-of select="process"/></process>
			</xsl:if>
			<xsl:if test="source_id">
				<source_id><xsl:value-of select="source_id"/></source_id>
			</xsl:if>
			<xsl:if test="gravity">
				<gravity><xsl:value-of select="attachment_id"/></gravity>
			</xsl:if>
			<xsl:if test="value">
				<error_value><xsl:value-of select="value"/></error_value>
			</xsl:if>
     		<xsl:if test="line_number">
				<line_number><xsl:value-of select="line_number"/></line_number>
			</xsl:if>
			<xsl:if test="column_number">
				<column_number><xsl:value-of select="column_number"/></column_number>
			</xsl:if>
			<xsl:if test="error_id">
				<error_id><xsl:value-of select="error_id"/></error_id>
			</xsl:if>
			<xsl:if test="error_level">
				<error_level><xsl:value-of select="error_level"/></error_level>
			</xsl:if>
  </com.misys.portal.product.common.ProductError>
</xsl:template>
</xsl:stylesheet>