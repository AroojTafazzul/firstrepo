<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	<!-- Get the parameters -->
	<xsl:include href="product_params.xsl"/>
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="static_user">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Copy all nodes and recursively its content-->
	<xsl:template match="* | text()">
		<xsl:copy>
			<xsl:apply-templates select="* | text()"/>
		</xsl:copy>
	</xsl:template>
	<!-- Template for the old password value -->
	<xsl:template match="old_password_value">
		<old_password_value>
			<xsl:value-of select="."/>
		</old_password_value>
	</xsl:template>
	<!-- Template for the password value -->
	<xsl:template match="password_value">
		<password_value>
			<xsl:value-of select="."/>
		</password_value>
	</xsl:template>
	<!-- Template for the password confirm -->
	<xsl:template match="password_confirm">
		<password_confirm>
			<xsl:value-of select="."/>
		</password_confirm>
	</xsl:template>
     <xsl:template match="landing_page_product">
      <landing_page_product>
       <xsl:value-of select="."/>
      </landing_page_product>
     </xsl:template>
     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
