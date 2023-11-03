<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for Transaction Confirmation Details Content.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      08/06/13

##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization xmlRender defaultresource">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language"/>
  <xsl:param name="collaborationmode">none</xsl:param>
  <xsl:param name="displaymode">view</xsl:param>
  
  <xsl:param name="rundata"/>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl"/>

  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ft_tnx_record"/>
  </xsl:template>
 
 <!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
  
  <xsl:variable name="iss_date">
  	<xsl:choose>
	  	<xsl:when test="iss_date[.!='']">
	  		<xsl:value-of select="iss_date"></xsl:value-of>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<xsl:value-of select="iss_date_unsigned"></xsl:value-of>
	  	</xsl:otherwise>
	</xsl:choose>
  </xsl:variable>
  
   <xsl:variable name="beneficiary_name">
  	<xsl:choose>
	  	<xsl:when test="beneficiary_name[.!='']">
	  		<xsl:value-of select="beneficiary_name"></xsl:value-of>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<xsl:value-of select="beneficiary_account"></xsl:value-of>
	  	</xsl:otherwise>
	</xsl:choose>
  </xsl:variable>
   
  <xsl:call-template name="fieldset-wrapper">
  	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
  		<xsl:with-param name="content">
			<xsl:call-template name="column-container">
				<xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_JURISDICTION_REFERENCE_ID</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="size">16</xsl:with-param>
						<xsl:with-param name="maxsize">16</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
						<xsl:with-param name="product-code">ft</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>							   		
						<xsl:with-param name="show-button">N</xsl:with-param>
						<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
						<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="applicant_act_name"/></xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>							
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_TRANSFER_TO</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="$beneficiary_name"/></xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>							
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="$iss_date"/></xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>							
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
  
  <xsl:value-of select="localization:getGTPString($language, 'CONFIRM_FORM_SUBMISSION')" disable-output-escaping="yes" />
</xsl:template>   	
 
</xsl:stylesheet>