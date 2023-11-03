<?xml version="1.0" encoding="UTF-8"?>


<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        exclude-result-prefixes="localization securitycheck utils">

	<!-- 
	 Global Parameters.
	 These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">BK</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/InvoiceScreen</xsl:param>
	<!-- Global Imports. -->
	<xsl:include href="common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/core_create_bk_details.xsl" /> 

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="bk_tnx_record"/>
	</xsl:template>
  
	
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.core.create_bk</xsl:with-param>
			<xsl:with-param name="override-help-access-key">BK_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	


</xsl:stylesheet>