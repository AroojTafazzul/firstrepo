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
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:import href='attachment_templates_core.xsl' />
<xsl:include href='../../../client/core/xsl/common/attachment_templates_client.xsl' />
</xsl:stylesheet>