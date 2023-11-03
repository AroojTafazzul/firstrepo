<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
 Transaction Bulk (BK) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      23/03/2012
author:    Pavan Kumar
##########################################################
-->

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
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BulkScreen</xsl:param>

	<!-- Global Imports. -->
	<xsl:include href="common/trade_common.xsl" />
	<xsl:include href="../../cash/xsl/common/ft_common.xsl" />
	<xsl:include href="bk_common.xsl"/>	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="bk_tnx_record"/>
	</xsl:template>
  <!-- 
	 BK TNX FORM TEMPLATE.
	-->
	<xsl:template match="bk_tnx_record">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message"/>
		
		<div>
		   <xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
		      		<xsl:call-template name="js-bulk-product-collections"/>
			      	<xsl:call-template name="bk-hidden-fields" />
			     <div id="content2">	      		
	      		    <xsl:call-template name="bulk-general-details" >
	      		      <xsl:with-param name="show-child-transactions">N</xsl:with-param>
	      		      <xsl:with-param name="show-eligible-bulks-for-merge">Y</xsl:with-param>
	      		    </xsl:call-template>
			    </div>
			    <xsl:call-template name="js-imports"/>
			    <xsl:call-template name="realform"/> 
			    </xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>

	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.core.merge_demerge_bk</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
		<!--
	Real form for Bulk
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="method">POST</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action"/>
			<xsl:with-param name="content">
				<div class="widgetContainer">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">referenceid</xsl:with-param>
						<xsl:with-param name="value" select="ref_id"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxid</xsl:with-param>
						<xsl:with-param name="value" select="tnx_id"/>
					</xsl:call-template>      
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">operation</xsl:with-param>
						<xsl:with-param name="id">realform_operation</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">mode</xsl:with-param>
						<xsl:with-param name="value" select="$mode"/>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option</xsl:with-param>
						<xsl:with-param name="value">BULK</xsl:with-param>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxtype</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">attIds</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bk_type</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">TransactionData</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>