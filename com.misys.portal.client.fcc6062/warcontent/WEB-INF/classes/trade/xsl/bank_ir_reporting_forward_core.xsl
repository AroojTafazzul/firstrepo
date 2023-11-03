<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Inward Remittance (IR) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
  <xsl:param name="product-code">IR</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" />
 
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="ir_tnx_record"/>
  </xsl:template>
 
 <!-- 
   IR TNX FORM TEMPLATE.
  -->
  <xsl:template match="ir_tnx_record">
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

    <!-- Transcation details link and control -->
    <xsl:call-template name="transaction-details-link">
     <xsl:with-param name="show-transaction">
      <xsl:choose>
       <xsl:when test="tnx_type_code[.!='01']">N</xsl:when>
       <xsl:otherwise>Y</xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>

    <div id="transactionDetails">
     <xsl:if test="tnx_type_code[.='01']">
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
       <xsl:call-template name="general-details"/>
       <xsl:call-template name="amt-details"/>
       
       <!-- Remitting Bank is Receiving bank -->
       <xsl:choose>
	       <xsl:when test="$displaymode='view'">
		       <!-- Shown in view mode only -->
		        <xsl:call-template name="fieldset-wrapper">
		         <xsl:with-param name="legend">XSL_BANKDETAILS_INWARD_REMITTANCE_TAB_REMITTANCE_BANK</xsl:with-param>
		         <xsl:with-param name="content">
		          <xsl:apply-templates select="remitting_bank">
		           <xsl:with-param name="prefix">remitting_bank</xsl:with-param>
		          </xsl:apply-templates>
		         </xsl:with-param>
		        </xsl:call-template>
	       </xsl:when>
	       <xsl:otherwise>
	       <!-- Shown in edit mode only -->
	          <xsl:apply-templates select="remitting_bank">
	            <xsl:with-param name="prefix">remitting_bank</xsl:with-param>
		      </xsl:apply-templates>
	       </xsl:otherwise>
       </xsl:choose>

       <!-- Issuing Bank is sanding bank -->
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_BANKDETAILS_INWARD_REMITTANCE_TAB_ISSUING_BANK</xsl:with-param>
        <xsl:with-param name="button-type">issuing_bank</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:apply-templates select="issuing_bank">
          <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
          <xsl:with-param name="show-button">N</xsl:with-param>
         </xsl:apply-templates>
        </xsl:with-param>
       </xsl:call-template>
       
       <!-- Payment Details -->
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
        <xsl:with-param name="content">
         <div>
          <xsl:if test="$displaymode = 'edit'">
   	       <xsl:attribute name="class">collapse-label</xsl:attribute>
   	      </xsl:if>
          <xsl:call-template name="big-textarea-wrapper">
           <xsl:with-param name="id">narrative_payment_details</xsl:with-param>
           <xsl:with-param name="type">textarea</xsl:with-param>
           <xsl:with-param name="content">
            <xsl:call-template name="textarea-field">
             <xsl:with-param name="name">narrative_payment_details</xsl:with-param>
             <xsl:with-param name="rows">4</xsl:with-param>
             <xsl:with-param name="cols">45</xsl:with-param>
            </xsl:call-template>
           </xsl:with-param>
          </xsl:call-template>
         </div>
        </xsl:with-param>
       </xsl:call-template>
       
       <xsl:call-template name="settlement-details"/>
      </xsl:with-param>
     </xsl:call-template>
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
   <xsl:with-param name="binding">misys.binding.bank.report_ir</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
   <xsl:with-param name="show-type">N</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  IR General Details
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TYPE</xsl:with-param>
     <xsl:with-param name="name">ir_type_code</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
        <option value="01">
         <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE_IR')" />
        </option>
	    <option value="02">
	     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE_IR_CHEQUE')" />
	    </option>
       </xsl:when>
       <xsl:otherwise>
        <xsl:choose>
         <xsl:when test="ir_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE_IR')" /></xsl:when>
         <xsl:when test="ir_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TYPE_IR_CHEQUE')" /></xsl:when>
        </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_IR_DATE</xsl:with-param>
     <xsl:with-param name="name">remittance_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <div>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">instructions_required</xsl:with-param>
      <xsl:with-param name="value">N</xsl:with-param>
     </xsl:call-template>
    </div>
    
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
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Remitter Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_REMITTER_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type">remitter</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="address">
       <xsl:with-param name="show-reference">Y</xsl:with-param>
       <xsl:with-param name="prefix">remitter</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  IR Amt Details
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
     <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_IR_AMT_LABEL2</xsl:with-param>
     <xsl:with-param name="product-code">ir</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">ir_liab_amt</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="ir_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="ir_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="ir_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="ir_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  IR Settlement Details
  -->
 <xsl:template name="settlement-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_NO</xsl:with-param>
     <xsl:with-param name="name">act_no</xsl:with-param>
      <xsl:with-param name="regular-expression">^[a-zA-Z0-9]*$</xsl:with-param>
     <xsl:with-param name="size">34</xsl:with-param>
     <xsl:with-param name="maxsize">34</xsl:with-param>
     <xsl:with-param name="button-type">account</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
     <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
      <xsl:with-param name="regular-expression">^[a-zA-Z0-9]*$</xsl:with-param>
     <xsl:with-param name="size">34</xsl:with-param>
     <xsl:with-param name="maxsize">34</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  Remitting bank  
 -->
 <xsl:template match="remitting_bank">
  <xsl:param name="prefix"/>
  
  <!-- Name. -->
  <xsl:choose>
	<xsl:when test="$displaymode='view'">
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
	   <xsl:with-param name="value" select="name"/>
	   <xsl:with-param name="required">Y</xsl:with-param>
	  </xsl:call-template>
	    <!-- Address Lines -->
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
	   <xsl:with-param name="value" select="address_line_1"/>
	   <xsl:with-param name="required">Y</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
	   <xsl:with-param name="value" select="address_line_2"/>
  	  </xsl:call-template>
	  <xsl:call-template name="input-field">
	   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
	   <xsl:with-param name="value" select="dom"/>
	  </xsl:call-template>
	  <div>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
	    <xsl:with-param name="value" select="iso_code"></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
	    <xsl:with-param name="value" select="reference"></xsl:with-param>
	   </xsl:call-template>
	  </div>
   </xsl:when>
  <xsl:otherwise>
   <div>
	   <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
	      <xsl:with-param name="value" select="name"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	      <xsl:with-param name="abbv_name"><xsl:value-of select="$prefix"/>_abbv_name</xsl:with-param>
	      <xsl:with-param name="value" select="abbv_name"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
		  <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
		  <xsl:with-param name="value" select="address_line_1"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
	     <xsl:with-param name="value" select="address_line_2"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
	    <xsl:with-param name="value" select="dom"/>
	   </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_iso_code</xsl:with-param>
	    <xsl:with-param name="value" select="iso_code"></xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
	    <xsl:with-param name="value" select="reference"></xsl:with-param>
	   </xsl:call-template>
  </div>
  </xsl:otherwise>
  </xsl:choose>
    
 </xsl:template>
</xsl:stylesheet>
