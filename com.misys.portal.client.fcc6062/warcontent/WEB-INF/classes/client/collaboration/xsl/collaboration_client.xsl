<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
 <!ENTITY nbsp "&#160;">
]>
<!--
##########################################################
Templates for

 Collaboration Floating Window.

Copyright (c) 2000-2009 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      23/01/09
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->

<xsl:stylesheet 
        version="1.0" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        xmlns:rundataservice="xalan://com.misys.portal.services.rundata.GTPRunDataService"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
        exclude-result-prefixes="localization securitycheck security rundataservice utils collabutils"></xsl:stylesheet>