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

	<!-- Copy all nodes and recursively its content-->
	<xsl:template match="* | text()">
		<xsl:copy>
			<xsl:apply-templates select="* | text()"/>
		</xsl:copy>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
