<?xml version="1.0"?>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	exclude-result-prefixes="businesscode" 
	xmlns:businesscode="xalan://com.misys.portal.common.resources.BusinessCodesResourceProvider" >

<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->

	<!-- Get the parameters -->
	<xsl:param name="companyType"/>
	<xsl:param name="customerType">
		<xsl:value-of select="businesscode:getValueOfBusinessCode('N010_CUSTOMER')"/>
	</xsl:param>
	<xsl:param name="IsEncrypted" select="'false'"/>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>

