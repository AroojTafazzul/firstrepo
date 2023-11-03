<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to E2EE of Transactions

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      19/01/2012
author:    Gurudath Reddy
email:     gurudath.reddy@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
 
 <xsl:strip-space elements="*"/>
  
 <xsl:param name="isTransactionE2EEEnabled"/>
 <xsl:param name="e2ee_content"/>
 
 <!-- Hidden Fields required for Transaction Data E2EE  -->
 <xsl:template name="e2ee_transaction">
 	<div class="widgetContainer hide" id="e2ee_content_div">
 		<xsl:value-of select="$e2ee_content" disable-output-escaping="yes"/>
 	</div>
 </xsl:template>
</xsl:stylesheet>