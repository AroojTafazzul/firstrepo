<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to FSCM forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs.

This should be the first include for forms on the customer side.

Copyright (c) 2000-2016 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      28/09/16
author:    Devika Saraswat
email:     devika.saraswat@misys.com
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
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization utils security"></xsl:stylesheet>