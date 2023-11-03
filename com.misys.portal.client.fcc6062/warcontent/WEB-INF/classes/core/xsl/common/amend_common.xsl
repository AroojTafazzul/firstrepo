<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to amendment forms (lc_amend, si_amend etc)
on the customer and bank sides.

Amendentment forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

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
<xsl:import href='amend_common_core.xsl' />
<xsl:include href='../../../client/core/xsl/common/amend_common_client.xsl' />
</xsl:stylesheet>