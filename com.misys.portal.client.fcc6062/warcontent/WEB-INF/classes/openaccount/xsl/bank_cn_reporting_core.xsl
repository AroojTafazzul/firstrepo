<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Credit Note Form (IP), Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
base version: 1.4
date:      09/04/2014
author:   Prateek/Uthkarsh
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
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">CN</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="show-template">N</xsl:param>	
 
  <!-- Global Imports. -->
  <!-- <xsl:include href="po_common.xsl" /> -->
  <xsl:include href="../../core/xsl/products/product_addons.xsl" />
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="trade_create_cn_details.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="cn_tnx_record"/>
  </xsl:template>
 
 <!-- 
   CN TNX FORM TEMPLATE.
  -->
  <xsl:template match="cn_tnx_record">
  
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <div>
   	<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
	
    <!-- Link to display transaction contents -->
    <!-- <xsl:call-template name="transaction-details-link"/> -->
    <div id="transactionDetails">
     <xsl:if test="tnx_type_code[.='01']">
     	<xsl:attribute name="style">display:block;</xsl:attribute>
     </xsl:if>
    </div>
     
			<!-- Form #0 : Main Form -->
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name" select="$main-form-name" />
		<xsl:with-param name="validating">Y</xsl:with-param>
		<xsl:with-param name="content">
			<!-- Disclaimer Notice -->
	        <xsl:call-template name="disclaimer"/>
	        
	        <xsl:call-template name="common-hidden-fields"/>
	        
	        <xsl:call-template name="general-details" />
			<xsl:if test="$option ='DETAILS' or $option = 'FULL'">
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template" select="$show-template"/>	
				</xsl:call-template>
				
				<!-- Bank details -->
				<xsl:call-template name="bank-details" />
			</xsl:if>
			
			<!-- Seller Details -->
			<xsl:if test="$displaymode = 'edit'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SELLER_DETAILS</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-entity">N</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">seller</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<!-- <xsl:with-param name="displaymode">view</xsl:with-param> -->
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			<!-- Buyer Details -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_BUYER_DETAILS</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-BEI">Y</xsl:with-param>
							<xsl:with-param name="prefix">buyer</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<!-- <xsl:with-param name="displaymode">view</xsl:with-param> -->
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
			</xsl:if>
			<xsl:call-template name="amount-details" />
			<xsl:call-template name="invoice-items-declaration"/>
			<xsl:call-template name="credit_note_invoices"/>
			<xsl:call-template name="message-freeFormat"/>
		</xsl:with-param>
	</xsl:call-template>
	
	  <xsl:call-template name="menu">
	   <xsl:with-param name="show-template">N</xsl:with-param>
	   <xsl:with-param name="second-menu">Y</xsl:with-param>
	   <xsl:with-param name="show-reject">N</xsl:with-param>
	  </xsl:call-template>
 </div>
  
	 <!-- Table of Contents -->
	 <xsl:call-template name="toc"/>
	 <!-- Javascript imports  -->
	 <xsl:call-template name="js-imports"/>
	 
</xsl:template>

 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">
  	<xsl:choose>
  		<xsl:when test="$option ='DETAILS'">misys.binding.openaccount.create_cn</xsl:when>
  		<xsl:otherwise>misys.binding.bank.report_cn</xsl:otherwise>
  	</xsl:choose>
  </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="general-details">
 	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
	 			<xsl:call-template name="common-general-details" >
	 				<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
	 				<xsl:with-param name="show-template-id">N</xsl:with-param>
	 			</xsl:call-template>
			 	<!-- Additional fields for Credit note -->
			 	<!-- Credit Note Reference -->
		 		<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_CN_REFERENCE</xsl:with-param>
				     <xsl:with-param name="name">cn_reference</xsl:with-param>
				     <xsl:with-param name="size">20</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				     <xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				
	    		<!-- FSCM Program -->
	    		
	    		<xsl:if test = "fscm_program_code[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N084',fscm_program_code )"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			    <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">fscm_program_code</xsl:with-param>
			    </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
 </xsl:template>
 
 <xsl:template name="amount-details">
		<div>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<div>
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_GENERALDETAILS_CN_AMOUNT</xsl:with-param>
						<xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
  
</xsl:stylesheet>