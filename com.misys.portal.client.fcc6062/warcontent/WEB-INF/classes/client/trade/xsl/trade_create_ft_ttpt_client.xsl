<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Fund Transfer (FT) Form, Customer Side.
 
 Note: Templates beginning with lc- are in lc_common.xsl

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
        xmlns:xmlCrossRef="xalan://com.misys.portal.product.util.CrossReferenceTool"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="xmlRender localization xmlCrossRef ftProcessing defaultresource securityCheck"></xsl:stylesheet>