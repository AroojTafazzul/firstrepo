<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Request for finance multiple selection IN, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      11/03/2017
author:    Meenal Sahasrabudhe
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"		  
       	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
		exclude-result-prefixes="localization convertTools">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="option">IN_FINANCE_REQUEST</xsl:param>
	<xsl:param name="product-code">IN</xsl:param>
	<xsl:param name="token"/>
	
	<!-- These params are empty for trade message -->
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/InvoiceScreen</xsl:param>
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../openaccount/xsl/request_financing_invoice.xsl"/>
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.fscm_financing_request</xsl:with-param>
			<xsl:with-param name="show-period-js">Y</xsl:with-param>
    		<xsl:with-param name="override-lowercase-product-code">in</xsl:with-param>
			<xsl:with-param name="override-help-access-key">IN_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="open_selected">
		<xsl:variable name="product-code"><xsl:value-of select="$product-code"/></xsl:variable>
		<xsl:variable name="lowercase-product-code">
		 	<xsl:value-of select="translate($product-code,$up,$lo)"/>
		</xsl:variable>
		<xsl:variable name="screen-name">InvoiceScreen</xsl:variable>
		<xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>
		<!-- Javascript and Dojo imports  -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">product_code</xsl:with-param>
			<xsl:with-param name="value">IN</xsl:with-param>				
		</xsl:call-template>
		<xsl:call-template name="js-imports">
			<xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
	    <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
	    <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
		</xsl:call-template>
		  <!-- Preloader  -->
		<xsl:call-template name="loading-message"/>
	  <div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
	
	   <!-- Form #0 : Main Form -->
	   <xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
		  	<xsl:call-template name="reauthentication" />
			<xsl:call-template name="open-selected-details"/>
		    <xsl:call-template name="menu">
				<xsl:with-param name="screen-name" select="$screen-name"/>
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="second-menu">Y</xsl:with-param>
				<xsl:with-param name="show-save">N</xsl:with-param>
				<xsl:with-param name="show-reject">N</xsl:with-param>
				<xsl:with-param name="show-return">N</xsl:with-param>
				<xsl:with-param name="show-submit">Y</xsl:with-param>
				<xsl:with-param name="show-cancel">N</xsl:with-param>
			</xsl:call-template>
		   </xsl:with-param>
	   </xsl:call-template>
	   <!-- Message realform. -->
	   <xsl:call-template name="realform">
	     <xsl:with-param name="action" select="$action"/>
	    </xsl:call-template>
	  </div>
	</xsl:template>
  <xsl:template name="hidden-fields">
	  	<xsl:param name="lowercase-product-code"/>
	   	<xsl:call-template name="common-hidden-fields">
		    <xsl:with-param name="show-type">N</xsl:with-param>
		    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
		    <xsl:with-param name="additional-fields">
				<xsl:if test="entity and entity[. != '']">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">entity</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">product_code</xsl:with-param>
					<xsl:with-param name="value">IN</xsl:with-param>				
				</xsl:call-template> 
		   </xsl:with-param>
	   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="disclaimer-column-wrapper">
	  	<xsl:param name="rightStyle">margin-left: 265px;</xsl:param>
	  	<xsl:param name="leftContent"></xsl:param>
	  	<xsl:param name="rightContent" />
		<div>
			<xsl:attribute name="style"><xsl:value-of select="$rightStyle" /></xsl:attribute>
			<xsl:value-of select="$rightContent" /> 
		</div>
  </xsl:template>
</xsl:stylesheet>