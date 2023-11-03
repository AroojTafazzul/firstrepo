<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Indemnity (LI) Form, Bank Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      17/05/10
author:    Cormac Flynn, Gauthier Pillon
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
	    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
		exclude-result-prefixes="localization xmlRender">


  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">LI</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>


	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/bank_common.xsl" />
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	
  	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="li_tnx_record"/>
	</xsl:template>
	

	 <!-- 
  	 LI TNX FORM TEMPLATE.
  		-->
	<xsl:template match="li_tnx_record">

	 <!-- Preloader  -->
  	 <xsl:call-template name="loading-message"/>

  	<div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Display common reporting area -->
    <xsl:call-template name="bank-reporting-area"/>
    
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
    
     <!-- The details of the LC are only shown if the beneficiary is not defined (it means that the transaction
           has been initiated through the Upload option and some mandatory fields are still missing  -->
   <!-- <xsl:choose>
     <xsl:when test="tnx_type_code[.='15' or .='13' or .='01']">
     --> 
	 <!-- Transaction details link and control -->
     <xsl:call-template name="transaction-details-link">
		<xsl:with-param name="show-transaction">
			<xsl:choose>
				<xsl:when test="tnx_type_code[.!='01'] and $displaymode='edit' or (tnx_type_code[.='01'] and $displaymode = 'edit')">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="show-hyperlink">
			<xsl:choose>
				<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03']) and defaultresource:getResource('ENABLE_EDITING_INIT_AMEND_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='13'] and defaultresource:getResource('ENABLE_EDITING_MSG_TNX_DETAILS_BY_BANK')='true'">Y</xsl:when>
				<xsl:when test="tnx_type_code[.='15']">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	 </xsl:call-template>
    
	<div id='transactionDetails'>
	  <xsl:call-template name="form-wrapper">
      <xsl:with-param name="name" select="$main-form-name"/>
      <xsl:with-param name="validating">Y</xsl:with-param>
      <xsl:with-param name="content">
      <h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
     <!-- Disclaimer Notice -->
       <xsl:call-template name="disclaimer"/>
       
       <xsl:call-template name="hidden-fields"/>
       <xsl:call-template name="general-details"/>
       <xsl:call-template name="amt-details"/>
       <xsl:call-template name="li-details"/>
       <xsl:call-template name="description-goods"/>
   
      </xsl:with-param>
     </xsl:call-template>
      
       </div>
      <!-- 
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="form-wrapper">
        <xsl:with-param name="name" select="$main-form-name"/>
        <xsl:with-param name="validating">Y</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:call-template name="common-hidden-fields"/>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose> -->

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
       
	
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.bank.report_li</xsl:with-param>
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
  <xsl:call-template name="common-hidden-fields"/>
  <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">principal_act_no</xsl:with-param>
    <xsl:with-param name="value" select="principal_act_no"/>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">fee_act_no</xsl:with-param>
    <xsl:with-param name="value" select="fee_act_no"/>
   </xsl:call-template>
  </div>
 </xsl:template>
 
<!--
  LI General Details 
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   <xsl:if test="tnx_type_code[.='15' or .='13']">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   <!-- 20170725_01 starts -->
   <xsl:if test="$displaymode='view' and tnx_type_code[.='01']">
	 
	    <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="iss_date"/>
	    </div></xsl:with-param>
	  	</xsl:call-template>    
	    
   </xsl:if>
   <!-- 20170725_01 ends -->
   <!-- Hidden fields -->
	  <xsl:if test="bo_lc_ref_id[.!='']">
	   <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bo_lc_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">lc_ref_id</xsl:with-param>
       </xsl:call-template>
	  </xsl:if>
     <xsl:if test="lc_ref_id[.!='']">
      <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bene_type_code</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bene_type_other</xsl:with-param>
       </xsl:call-template>
	 </xsl:if>
	  <!-- BO_lc_ref_id -->
	  <!-- <xsl:choose>
		<xsl:when test="bo_lc_ref_id[.!='']">
	  			<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
	      	      	<xsl:with-param name="name">bo_lc_ref_id</xsl:with-param>
	            	 <xsl:with-param name="value" select="bo_lc_ref_id" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
	     	</xsl:when>
		<xsl:otherwise>
				<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
			  	<xsl:with-param name="name">alt_lc_ref_id</xsl:with-param>
					<xsl:with-param name="size">15</xsl:with-param>
	       		<xsl:with-param name="maxsize">20</xsl:with-param>
	       		</xsl:call-template>
		</xsl:otherwise>
	  </xsl:choose> -->
     <!-- deal_ref_id -->
     <!-- 20170725_01 starts -->
    <xsl:if test="$displaymode='view' and not(tnx_id)">
	 
	    <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	     <xsl:value-of select="iss_date"/>
	    </div></xsl:with-param>
	  	</xsl:call-template>    
	    
   </xsl:if>
   <!-- 20170725_01 ends -->
     <xsl:choose>
     <xsl:when test="cross_references/cross_reference/type_code[.='02']">
       <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
        <xsl:with-param name="id">tnx_parent_bo_ref_id_view</xsl:with-param>
        <xsl:with-param name="value" select="$parent_file/bo_ref_id"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
       </xsl:call-template>     
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_GENERALDETAILS_RELATED_REF_ID</xsl:with-param>
      	<xsl:with-param name="name">deal_ref_id</xsl:with-param>
      	<xsl:with-param name="readonly">Y</xsl:with-param> 
      	<xsl:with-param name="size">15</xsl:with-param>
        <xsl:with-param name="maxsize">34</xsl:with-param>
     </xsl:call-template> 
     </xsl:otherwise>
     </xsl:choose>
	 
   
   <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
   
    <!-- Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type"><xsl:if test="tnx_type_code[.='01']">applicant</xsl:if></xsl:with-param>
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
       <xsl:with-param name="prefix">applicant</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   <div id="beneficiarydetails">
    <xsl:variable name="beneficiaryHeader">
                <xsl:choose>
                   <xsl:when test="//*/cross_references/cross_reference[product_code='EL']">XSL_HEADER_BENEFICIARY_DETAILS_BUYER</xsl:when>
                   <xsl:when test="//*/cross_references/cross_reference[product_code='LC']">XSL_HEADER_BENEFICIARY_DETAILS_TRANS_COMP</xsl:when>
                   <xsl:otherwise>XSL_HEADER_BENEFICIARY_DETAILS</xsl:otherwise>
                </xsl:choose>
        </xsl:variable>
     <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="button-type">beneficiary</xsl:with-param>
     <xsl:with-param name="content">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_PARTIESDETAILS_TYPE_LABEL</xsl:with-param>
      <xsl:with-param name="name">bene_type_code</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
    	<xsl:when test="$displaymode='edit'">
     	<option value=""/>
     	<option value="01">
      	<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_01_SHIPPER')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_02_BUYER')"/>
     </option>
     <option value="99">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_99_OTHER')"/>
     </option>
     </xsl:when>
       <xsl:otherwise>
     	<xsl:if test="bene_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_01_SHIPPER')"/></xsl:if>
        <xsl:if test="bene_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_02_BUYER')"/></xsl:if>
        <xsl:if test="bene_type_code[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_99_OTHER')"/></xsl:if>
     </xsl:otherwise>
     </xsl:choose>
     </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
       <xsl:with-param name="name">bene_type_other</xsl:with-param>
       <xsl:with-param name="size">35</xsl:with-param>
       <xsl:with-param name="maxsize">255</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="address">
       <xsl:with-param name="prefix">beneficiary</xsl:with-param>
       <xsl:with-param name="show-reference">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
     
    </xsl:call-template>
    </div>
    
    <!-- Issuing Bank Details -->
    <xsl:call-template name="fieldset-wrapper">
     <xsl:with-param name="legend">XSL_TRANSACTIONDETAILS_ISSUING_BANK</xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
     <xsl:with-param name="content">
     	<xsl:call-template name="issuing_bank">
          <xsl:with-param name="prefix" select="'issuing_bank'"/>
        </xsl:call-template>
        </xsl:with-param>
     </xsl:call-template>
    
    </xsl:with-param>
    </xsl:call-template>
   </xsl:template> 
   
   <xsl:template name="issuing_bank">
   <xsl:param name="prefix"/>
       
   <xsl:variable name="issuing-bank-name-value">
     <xsl:value-of select="//*[name()=$prefix]/name"/>
   </xsl:variable>
   
   <xsl:variable name="appl_ref">
	  <xsl:value-of select="applicant_reference"/>
   </xsl:variable>
  <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	   <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
	   <xsl:with-param name="value" select="$issuing-bank-name-value"/>
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
 
<!-- 
  Amount Details 
  -->
 <xsl:template name="amt-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="currency-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_LI_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="product-code">li</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
     <xsl:with-param name="name">li_liab_amt</xsl:with-param>
     <xsl:with-param name="appendClass">outstanding</xsl:with-param>
     <xsl:with-param name="size">20</xsl:with-param>
     <xsl:with-param name="maxsize">15</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="type">amount</xsl:with-param>
     <xsl:with-param name="currency-value"><xsl:value-of select="//*[name()='li_cur_code']"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:if test="li_liab_amt[.!='']">
       <xsl:choose>
        <xsl:when test="$displaymode='view'">
         <xsl:value-of select="li_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="li_liab_amt"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="li_liab_amt"/></xsl:otherwise>
       </xsl:choose>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 
 <!-- Letter Of indemnity details -->  
   <xsl:template name="li-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_LI_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_COUNTERSIGNATURE</xsl:with-param>
      <xsl:with-param name="name">countersign_flag</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
    	<xsl:when test="$displaymode='edit'">
     	<option value=""/>
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
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_CARRIER_NAME</xsl:with-param>
      <xsl:with-param name="name">shipping_by</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="select-field">
		<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRANS_DOC_TYPE</xsl:with-param>
		<xsl:with-param name="name">trans_doc_type_code</xsl:with-param>
		<xsl:with-param name="options">
		  <xsl:call-template name="product_type_code_options"/>
		</xsl:with-param>
	 </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="$displaymode='view'">
      			<xsl:variable name="doc_type_code"><xsl:value-of select="trans_doc_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C014</xsl:variable>
      		<xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRANS_DOC_TYPE</xsl:with-param>
		      <xsl:with-param name="name">trans_doc_type_code</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="disabled"><xsl:if test="trans_doc_type_code[.!='']">Y</xsl:if></xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="trans_doc_type_code[.!='']"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $doc_type_code)"/></xsl:if></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="input-field">
		<xsl:with-param name="label"></xsl:with-param>
		<xsl:with-param name="name">trans_doc_type_other</xsl:with-param>
	  </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRANS_DOC_REF</xsl:with-param>
      <xsl:with-param name="name">bol_number</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">20</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRANS_DOC_DATE</xsl:with-param>
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