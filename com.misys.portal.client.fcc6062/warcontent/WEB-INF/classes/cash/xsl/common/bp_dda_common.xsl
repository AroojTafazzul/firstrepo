<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to FT forms on the customer and bank side. This
stylesheet should be the first thing imported by customer-side or bank side
XSLTs.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      27/10/11
author:    Lithwin
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:import href='bp_dda_common_core.xsl' />
<xsl:include href='../../../client/cash/xsl/common/bp_dda_common_client.xsl' />
</xsl:stylesheet>