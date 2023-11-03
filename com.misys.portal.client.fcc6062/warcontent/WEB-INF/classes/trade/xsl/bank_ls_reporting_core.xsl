<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 License (LS) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/08/14
author:    Shailly Palod
email:     shailly.palod@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
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
  <xsl:param name="product-code">LS</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ls_tnx_record"/>
  </xsl:template>
 
 <!-- 
   LS TNX FORM TEMPLATE.
  -->
  <xsl:template match="ls_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/> 
    <xsl:call-template name="build-inco-terms-data"/>
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
	<xsl:choose>
			<xsl:when test ="sub_tnx_stat_code[.='17']">
				     <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
				       <xsl:with-param name="title-size">35</xsl:with-param>
				      </xsl:call-template> 
			</xsl:when>
			<xsl:otherwise>
				     <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
				       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02' or type = '01']"/>
				       <xsl:with-param name="title-size">35</xsl:with-param>
				      </xsl:call-template> 
			</xsl:otherwise>
		</xsl:choose>

	</xsl:if>

     <!-- Link to display transaction contents -->
     <xsl:call-template name="transaction-details-link">
	   	 <xsl:with-param name="show-hyperlink">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.='01'] and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		 </xsl:with-param>
     </xsl:call-template>
     
     <div id="transactionDetails">
      <xsl:if test="$displaymode='view'">
       <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="form-wrapper">
       <xsl:with-param name="name" select="$main-form-name"/>
       <xsl:with-param name="validating">Y</xsl:with-param>
       <xsl:with-param name="content">
        <xsl:if test="tnx_type_code[.!='01']">
         <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
        </xsl:if>
        
        <!-- Disclaimer Notice -->
        <xsl:call-template name="disclaimer"/>
        
        <xsl:call-template name="hidden-fields"/>
        <xsl:call-template name="general-details" />
       
        <xsl:call-template name="ls-amt-details">
         <xsl:with-param name="override-product-code">ls</xsl:with-param>
         <xsl:with-param name="show-outstanding-amt">Y</xsl:with-param>
        </xsl:call-template>
       
        <xsl:call-template name="ls-validity-details"/>
        
        <!-- Bank details -->
        <xsl:call-template name="fieldset-wrapper">
		     <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		     <xsl:with-param name="content">
		     	<xsl:call-template name="bank_details">
		          <xsl:with-param name="prefix" select="'issuing_bank'"/>
		        </xsl:call-template>
		        </xsl:with-param>
	     </xsl:call-template>
         
	    <xsl:call-template name="ls-shipment-details"/>
	    
	      <!-- Narrative Details -->
	    <xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
		    <xsl:with-param name="content">
		    <xsl:call-template name="ls-narrative-details">
		    	<xsl:with-param name="in-fieldset">N</xsl:with-param>
		    </xsl:call-template>
      	    </xsl:with-param>
        </xsl:call-template>
        
       </xsl:with-param>
      </xsl:call-template>
     </div>
   		 
  <xsl:call-template name="menu">
   <xsl:with-param name="show-template">N</xsl:with-param>
   <xsl:with-param name="second-menu">Y</xsl:with-param>
  </xsl:call-template>
 </div>
  
 <!-- Table of Contents -->
 <xsl:call-template name="toc"/>

 <!-- Javascript imports  -->
 <xsl:call-template name="js-imports"/>
</xsl:template>

	<xsl:template name="bank_details">
		<xsl:param name="prefix"/>
		<xsl:variable name="bank-name-value">
			<xsl:value-of select="//*[name()=$prefix]/name"/>
		</xsl:variable>
		
		<xsl:variable name="appl_ref">
		  <xsl:value-of select="applicant_reference"/>
	    </xsl:variable>
   
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
			<xsl:with-param name="value" select="$bank-name-value"/>
			<xsl:with-param name="readonly">Y</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
	  	   <xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	  	   <xsl:with-param name="value">
	  	   	<xsl:value-of select="//*/customer_references/customer_reference[reference=$appl_ref]/description"/>
	  	   </xsl:with-param>
	       <xsl:with-param name="readonly">Y</xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
 
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.bank.report_ls</xsl:with-param>
   <xsl:with-param name="show-period-js">Y</xsl:with-param>   
   <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
  <xsl:with-param name="show-type">N</xsl:with-param>
   <xsl:with-param name="additional-fields">
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_ls_liab_amt</xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$displaymode='edit'">
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_ls_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_ls_amt" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_additional_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_add_amt" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">org_total_amt</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="org_total_amt" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="sub_tnx_type_code" /></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_type_code</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="tnx_type_code" /></xsl:with-param>
    </xsl:call-template>
    </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  General Details 
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
     <xsl:call-template name="ls-general-details">
     	<xsl:with-param name="show-iss-date">N</xsl:with-param>
     </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
</xsl:stylesheet>