<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:java="http://xml.apache.org/xalan/java"
		exclude-result-prefixes="java">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>
<xsl:param name="feeType" />
<xsl:param name="facilityid" />
<xsl:param name="facilityName" />



<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

<!-- main -->
<xsl:template match="/">
	<xsl:apply-templates select="outStandingDetail"/>
</xsl:template>
 
<xsl:template match="outStandingDetail">
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform2</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">	
			    <xsl:call-template name="fac-outstanding-details" />
			</xsl:with-param>
		</xsl:call-template>
	</div>
	
</xsl:template>

<!-- Outstanding details -->
<xsl:template name="fac-outstanding-details">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_FAC_OUTSTANDING_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XSL_LOAN_BORROWER_REFERENCE</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="//outStandingDetail/borrower_reference"/></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">DEAL_NAME</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="//outStandingDetail/deal_name"/></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XSL_LINKEDLOANDETAILS_FACILITY_NAME</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="//outStandingDetail/facility_name"/></xsl:with-param> 
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
</xsl:stylesheet>