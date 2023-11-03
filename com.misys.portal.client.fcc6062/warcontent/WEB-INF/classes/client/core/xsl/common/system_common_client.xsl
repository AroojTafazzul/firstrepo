<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
XSLT templates that are common to all system pages (profile,user, bank, company etc).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization security securityCheck"></xsl:stylesheet>
