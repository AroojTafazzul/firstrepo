<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to FT forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs.

This should be the first include for forms on the customer side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/05/11
author:    Sangeetha
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:import href='lep_common_core.xsl' />
<xsl:include href='../../../client/cash/xsl/common/lep_common_client.xsl' />
</xsl:stylesheet>