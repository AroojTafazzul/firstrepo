<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Template details for terminate recurring payment

Fund Transfer (FT) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      25/06/12
author:    Raja Rao
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        exclude-result-prefixes="xmlRender localization ftProcessing"></xsl:stylesheet>