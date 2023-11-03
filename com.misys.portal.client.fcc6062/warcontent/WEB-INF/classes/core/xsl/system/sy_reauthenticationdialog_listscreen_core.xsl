<?xml version="1.0" encoding="UTF-8"?>
<!--
########################################################## 
Templates for Re Authentication Page. 
Copyright (c) 2000-2013 Misys (http://www.misys.com), 
All Rights Reserved. 
version: 1.0 
date: 10/01/12 
author: Sam Sundar K 
##########################################################
-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl" />
	<xsl:include href="sy_reauthenticationdialog.xsl" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="product-code"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="realform-action"/>
	<xsl:param name="collaborationmode">none</xsl:param>

	<xsl:template match="/">
		<xsl:call-template name="reauthentication"></xsl:call-template>
	</xsl:template>

</xsl:stylesheet>