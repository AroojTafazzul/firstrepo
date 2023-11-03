<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Request for Foreign Exchange (XO) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
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

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">XO</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/ForeignExchangeOrderScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="./xo_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="xo_tnx_record"/>
  </xsl:template>
  
  <!-- 
   FX TNX FORM TEMPLATE.
  -->
  <xsl:template match="xo_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <xsl:apply-templates select="errors"/>
   
   <div >
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-save">Y</xsl:with-param>
       <xsl:with-param name="show-submit">Y</xsl:with-param>
       <xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
		
      <!-- FX Details. -->
      <xsl:call-template name="xo-details">
      	<xsl:with-param name="id">request-details</xsl:with-param>
      </xsl:call-template>
      
     </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
    <!--  
    <xsl:call-template name="attachments-file-dojo"/>
	-->
	
    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
		<xsl:with-param name="show-save">Y</xsl:with-param>
	    <xsl:with-param name="show-submit">Y</xsl:with-param>
	    <xsl:with-param name="show-template">N</xsl:with-param>
	    <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->
   <!--       
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id"></xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param>
   </xsl:call-template>
 	-->
 
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

<!--                                     -->  
<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
<!--                                     -->

<!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.cash.TradeCreateXoBinding</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

  <!--
    FX General Details Fieldset.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">

     <!-- Common general details. -->
     <xsl:call-template name="common-general-details">
      <xsl:with-param name="show-template-id">N</xsl:with-param>
     </xsl:call-template>

	<!-- Applicant Details -->
	<!-- Hidden fields since show-name and show-address disabled after -->
	<xsl:call-template name="hidden-field">
      <xsl:with-param name="name">applicant_name</xsl:with-param>
      <xsl:with-param name="value" select="applicant_name"/>
     </xsl:call-template>
	<xsl:call-template name="hidden-field">
      <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
      <xsl:with-param name="value" select="applicant_address_line_1"/>
     </xsl:call-template>
	<xsl:call-template name="hidden-field">
      <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
      <xsl:with-param name="value" select="applicant_address_line_2"/>
     </xsl:call-template>
	<xsl:call-template name="hidden-field">
      <xsl:with-param name="name">applicant_dom</xsl:with-param>
      <xsl:with-param name="value" select="applicant_dom"/>
     </xsl:call-template>
    <xsl:if test="entities[.!='0']">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:if test="$displaymode='edit'">
					<script>
						dojo.ready(function(){
							misys._config = misys._config || {};
							misys._config.customerReferences = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
						});
					</script>
				</xsl:if>
				<!-- Applicant Details -->				
				<xsl:call-template name="address">
					<xsl:with-param name="show-entity">Y</xsl:with-param>
					<xsl:with-param name="show-name">N</xsl:with-param>
					<xsl:with-param name="show-address">N</xsl:with-param>
					<xsl:with-param name="prefix">applicant</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
     
	<!-- Bank Name -->
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="issuing-bank-tabcontent"/>    
		</xsl:with-param>
	</xsl:call-template>     
     
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template> 
 
  <!--
   Hidden fields for Request for Financing
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
      <xsl:with-param name="name">tnxtype</xsl:with-param>
      <xsl:with-param name="value">01</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">attIds</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">option</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>