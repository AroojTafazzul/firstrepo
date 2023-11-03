<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Generic templates for attaching files, documents, charges etc. to transactions, followed
by specific implementations for each attachment type. 

Global variables referenced in these templates
 $main-form-name

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
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization utils defaultresource"></xsl:stylesheet>