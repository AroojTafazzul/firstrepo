<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:urldecoder="xalan://java.net.URLDecoder"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:java="http://xml.apache.org/xalan/java"
		exclude-result-prefixes="localization loanIQ utils urldecoder defaultresource java">


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
	<xsl:apply-templates select="feeDetails"/>
</xsl:template>

  
<!-- 
  LN TNX FORM TEMPLATE.
 -->
 
 

 
<xsl:template match="feeDetails">
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>
	<!-- Javascript and Dojo imports  -->
	<xsl:call-template name="js-imports"/>
	
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform2</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">	
				<xsl:call-template name="fac-fee-inquiry" />
			    <xsl:call-template name="fee-details" />
			</xsl:with-param>
		</xsl:call-template>
	</div>
<!-- 	<xsl:call-template name="reauthentication"/>  -->
	
</xsl:template>
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
	<xsl:with-param name="binding">misys.binding.loan.facility_ongoing_fee_details</xsl:with-param>
	<xsl:with-param name="show-period-js">Y</xsl:with-param>		
</xsl:call-template>
	
</xsl:template>

 <xsl:template name="fac-fee-inquiry">
   <div style="text-align: right">	
   <xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="content">
   		
		<xsl:call-template name="button-wrapper">
			<xsl:with-param name="label">XSL_FEE_INQUIRY</xsl:with-param>
			<xsl:with-param name="id">addLoan</xsl:with-param>
			<xsl:with-param name="class">downloadPDF</xsl:with-param>
			<xsl:with-param name="onclick">misys.goToFacFeeInquiry();</xsl:with-param>
			<xsl:with-param name="show-text-label">Y</xsl:with-param>
		</xsl:call-template>
   	</xsl:with-param>
   </xsl:call-template>
   </div>
</xsl:template>

<!-- Fee details -->
<xsl:template name="fee-details">
	<xsl:variable name="ongoingRecords"><xsl:value-of select="defaultresource:getResource('LOAN_NUMBER_OF_FEE_ONGOING_RECORDS')"/></xsl:variable>
	<xsl:variable name="arrayList" select="java:java.util.ArrayList.new()"/>
	<xsl:variable name="void" select="java:add($arrayList, $ongoingRecords)"/>
	<xsl:variable name="args1" select="java:toArray($arrayList)"/>
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_FACILITIES_DETAILS_TITTLE</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="urldecoder:decode(//feeDetails/facilityName)"/></xsl:with-param>  
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XSL_FEE_TYPE</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="//feeDetails/feeType"/></xsl:with-param>  
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">facilityId</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="//feeDetails/facilityID" /></xsl:with-param>						
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">borrowerId</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="//feeDetails/borrowerID" /></xsl:with-param>						
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">effectiveDate</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="//feeDetails/effectiveDate" /></xsl:with-param>						
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">dueDate</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="//feeDetails/dueDate" /></xsl:with-param>												
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<div style="margin-left:20px;margin-bottom:1em;font-size:10pt">
	<p>
	<xsl:value-of select="localization:getFormattedString($language, 'XSL_FEE_DETAILS_INFO_MESSAGE', $args1)"></xsl:value-of>
	</p>
</div>

</xsl:stylesheet>
