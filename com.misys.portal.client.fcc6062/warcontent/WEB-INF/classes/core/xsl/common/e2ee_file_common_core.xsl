<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to E2EE of File
Copyright (c) 2000-2016 Misys (http://www.misys.com),
All Rights Reserved. 

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
  
 <xsl:param name="isFileE2EEEnabled"/>
 <xsl:param name="e2ee_file_content"/>
 
 <!-- Hidden Fields required for File Data E2EE  -->
 <xsl:template name="e2ee_file">
 	<div class="widgetContainer hide" id="e2ee_content_div">
 		<xsl:value-of select="$e2ee_file_content" disable-output-escaping="yes"/>
 	</div>
 </xsl:template>
</xsl:stylesheet>