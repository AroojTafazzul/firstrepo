<!--
########################################################## 
Templates for Re Authentication Page. 
Copyright (c) 2000-2013 Misys (http://www.misys.com), 
All Rights Reserved. 
version: 1.0 
date: 10/01/12 
author: Sam Sundar K 
##########################################################
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="localization" >
	<xsl:output method="txt"  indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/"><xsl:value-of select="account/cur_code" /><xsl:text> </xsl:text><xsl:value-of select="account/account_no" /><xsl:text> </xsl:text><xsl:value-of select="localization:getDecode(language, 'N068', account/account_type)" /></xsl:template></xsl:stylesheet>