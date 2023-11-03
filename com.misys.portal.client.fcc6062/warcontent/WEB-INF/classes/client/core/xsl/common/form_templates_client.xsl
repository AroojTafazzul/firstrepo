<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
XSLT templates for HTML elements and general form layout, that are common to all pages that 
contain forms. This is divided into two sections - the first lists all HTML element templates, 
the second lists all other templates used in forms.

This is already imported by trade_common.xsl, bank_common.xsl and system_common.xsl.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
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
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    xmlns:xmlutils="xalan://com.misys.portal.common.tools.XMLUtils"
    xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    exclude-result-prefixes="localization securityCheck">
</xsl:stylesheet>