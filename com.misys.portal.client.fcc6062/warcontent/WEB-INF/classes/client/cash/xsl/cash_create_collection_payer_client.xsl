<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Bulk Collection Payer Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      27/12/11
author:    Ramesh M
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
       exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils"></xsl:stylesheet>