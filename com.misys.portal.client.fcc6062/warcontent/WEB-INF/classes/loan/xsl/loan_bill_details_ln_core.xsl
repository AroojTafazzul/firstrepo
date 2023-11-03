<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loaniq.LoanIQAdapter"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization backoffice utils defaultresource">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="billId"/>
<xsl:param name="billType"/>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>


<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

 <xsl:template match="/">
    <xsl:apply-templates select="billDetails"/>
    <xsl:apply-templates select="billDetailsPDF"/>
  </xsl:template>
  
  
<!-- main -->
<xsl:template match="billDetails">
	<xsl:call-template name="fieldset-wrapper">
		  <xsl:with-param name="legend">XSL_HEADER_BILL_DETAILS</xsl:with-param>
	      <xsl:with-param name="content">
	             <xsl:call-template name="bill-Id" />
				 <xsl:call-template name="bill-contents"/>
		  </xsl:with-param>	
	</xsl:call-template>
</xsl:template>	

<!-- main -->
<xsl:template match="billDetailsPDF">
	<xsl:call-template name="fieldset-wrapper">
		  <xsl:with-param name="legend">XSL_HEADER_BILL_DETAILS</xsl:with-param>
	      <xsl:with-param name="content">
	             <xsl:call-template name="bill-Id" />
				 <xsl:call-template name="bill-contents-pdf"/>
		  </xsl:with-param>	
	</xsl:call-template>
</xsl:template>	

<xsl:template name="bill-Id">				
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">BILL_ID</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<div style="font-weight:bold;"><xsl:value-of select="$billId"/></div>
			</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="bill-contents">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BILL_CONTENTS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
					<pre><xsl:value-of select="details"/></pre>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="bill-contents-pdf">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BILL_CONTENTS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="button-wrapper">
		         <xsl:with-param name="label">DOWNLOAD_PDF</xsl:with-param>
		         <xsl:with-param name="id">downloadPDF</xsl:with-param>
		         <xsl:with-param name="class">downloadPDF</xsl:with-param>
		         <xsl:with-param name="onclick">misys.popup.showPDF('/screen/BillScreen?option=EXPORT_PDF&amp;bill_id=<xsl:value-of select="$billId"/>&amp;bill_type=<xsl:value-of select="$billType"/>');return false;</xsl:with-param>
		         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

 
</xsl:stylesheet>
