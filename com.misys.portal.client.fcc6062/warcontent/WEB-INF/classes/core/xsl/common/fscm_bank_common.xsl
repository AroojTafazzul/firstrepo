<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to forms on the bank side. This
stylesheet should be the first thing imported by bank-side
XSLTs.

This should be the first include for forms on the bank side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
base version: 1.9
date:      03/03/2011
author:    pavan kumar
email:     pavankumar.c@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:import href='fscm_bank_common_core.xsl' />
<xsl:include href='../../../client/core/xsl/common/fscm_bank_common_client.xsl' />
</xsl:stylesheet>