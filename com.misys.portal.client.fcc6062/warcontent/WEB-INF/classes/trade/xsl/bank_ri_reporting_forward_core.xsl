<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
##########################################################
Templates for

 Received Letter Of Indemnity (RI) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      14/01/11
author:    Saïd SAI
email:     said.sai@misys.com
##########################################################
-->
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
  <xsl:param name="product-code">RI</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ri_tnx_record"/>
  </xsl:template>
 
  <!-- 
   RI TNX FORM TEMPLATE.
  -->
  <xsl:template match="ri_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area">
    	<xsl:with-param name="forward">Y</xsl:with-param>
    </xsl:call-template>
    
    <!-- Attachments -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
    
    <!-- Transaction details link and control -->
    <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	 </xsl:call-template>
    
    <div id="transactionDetails">
     <xsl:if test="$displaymode='view'">
      <xsl:attribute name="style">position:relative;left:0;</xsl:attribute>
     </xsl:if>
     <!-- Form #0 : Main Form -->
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
       <xsl:call-template name="general-details"/>
       <xsl:call-template name="amt-details"/>
       <xsl:call-template name="ri-details"/>
       <xsl:call-template name="description-goods"/>
       
      </xsl:with-param>
     </xsl:call-template>
    
    
     <!-- Bank Details -->
    </div>
    
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-submit">N</xsl:with-param>
     <xsl:with-param name="show-forward">Y</xsl:with-param>
     <xsl:with-param name="show-reject">Y</xsl:with-param>
    </xsl:call-template>
   </div>
   
  <!-- Table of Contents -->
  <xsl:call-template name="toc"/>
  
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
   <xsl:with-param name="binding">misys.binding.bank.report_ri</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
  </xsl:call-template>
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ic_type_code</xsl:with-param>
    <xsl:with-param name="value" select="ic_type_code"/>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!--
  RI General Details 
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <!-- Show in consolidated view. -->
    <xsl:if test="$displaymode='view'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_CREATION_DATE</xsl:with-param>
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
    
    <!-- Beneficiary Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type"><xsl:if test="tnx_type_code[.='01']">bank-beneficiary</xsl:if></xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-entity">
        <xsl:choose>
         <xsl:when test="entity[.='']">N</xsl:when>
         <xsl:otherwise>Y</xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
       <xsl:with-param name="show-entity-button">N</xsl:with-param>
       <xsl:with-param name="entity-required">N</xsl:with-param>
       <xsl:with-param name="show-abbv">Y</xsl:with-param>
       <xsl:with-param name="disabled">Y</xsl:with-param>
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
      </xsl:call-template>
      <!-- RI Type Code -->
      <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_PARTIESDETAILS_TYPE_LABEL</xsl:with-param>
	      <xsl:with-param name="name">ri_type_code</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:choose>
	        <xsl:when test="$displaymode='edit'">
	     	  <option value=""/>
	          <option value="01">
	        	<xsl:value-of select="localization:getDecode($language, 'N106', '01')"/>
	          </option>
	          <option value="02">
	            <xsl:value-of select="localization:getDecode($language, 'N106', '02')"/>
	          </option>
	          <option value="99">
	            <xsl:value-of select="localization:getDecode($language, 'N106', '99')"/>
	          </option>
	        </xsl:when>
	        <xsl:otherwise>
	          <xsl:if test="ri_type_code[.!='']">
	            <option>
	              <xsl:attribute name="value"><xsl:value-of select="ri_type_code"/> </xsl:attribute>
	              <xsl:value-of select="localization:getDecode($language, 'N106', ri_type_code)"/>
	            </option>
	          </xsl:if>
	        </xsl:otherwise>
	       </xsl:choose>
	      </xsl:with-param>
	  </xsl:call-template>
	  
     </xsl:with-param>
    </xsl:call-template>
   
     <!-- Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type">applicant</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="prefix">applicant</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   	 
   	 
   </xsl:with-param>
  </xsl:call-template>
  
 </xsl:template>
 
 <!-- 
  RI Amount Details
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_RECEIVED_INMT_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">ri</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">ri_liab_amt</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="ri_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="ri_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="ri_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="ri_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 

 <!-- Received Letter Of indemnity details -->  
   <xsl:template name="ri-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_LI_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_COUNTERSIGNATURE</xsl:with-param>
      <xsl:with-param name="name">countersign_flag</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
    	<xsl:when test="$displaymode='edit'">
     	<option value="Y">
	      	<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
    	 </option>
	     <option value="N">
	     	<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
	     </option>
       </xsl:when>
       <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="countersign_flag[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
          <xsl:when test="countersign_flag[. = 'N']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
     </xsl:choose>
     </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIPPING_BY</xsl:with-param>
      <xsl:with-param name="name">shipping_by</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_BOL_NUMBER</xsl:with-param>
      <xsl:with-param name="name">bol_number</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">20</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_BOL_DATE</xsl:with-param>
      <xsl:with-param name="name">bol_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
     
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
 <!-- Description of Goods -->
  <xsl:template name="description-goods">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">narrative_description_goods</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
        <xsl:with-param name="rows">12</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
 
 
</xsl:stylesheet>