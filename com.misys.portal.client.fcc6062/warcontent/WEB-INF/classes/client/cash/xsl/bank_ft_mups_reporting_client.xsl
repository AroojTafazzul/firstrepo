<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
India Domestic Fund Transfer (FT-MUPS) Form.

Copyright (c) 2000-2018 Finastra (http://www.finastra.com),
All Rights Reserved. 

version:   1.0
date:      16/11/2018
author:    Aneesh J
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security"></xsl:stylesheet>