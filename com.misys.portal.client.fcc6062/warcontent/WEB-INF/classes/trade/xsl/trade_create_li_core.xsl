<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter Of Indemnity (LI) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn, Gauthier Pillon
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="xmlRender localization utils defaultresource">
        
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LetterOfIndemnityScreen</xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />

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

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>    
	  <xsl:apply-templates select="cross_references" mode="hidden_form"/>      
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
     <xsl:call-template name="basic-amt-details">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_LI_AMT_LABEL</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="li-details"/>
      <xsl:call-template name="description-goods"/>

      <xsl:call-template name="bank-instructions">
       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
      </xsl:call-template>
      
      <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
       <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>

     </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <xsl:call-template name="realform"/>
 
   <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>

   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   
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
   <xsl:with-param name="binding">misys.binding.trade.create_li</xsl:with-param>
   <xsl:with-param name="override-help-access-key">LI_01</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:if test="cross_references">
   <div class="widgetContainer">
  	<xsl:call-template name="hidden-field">
    <xsl:with-param name="name">org_li_amt</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="li_amt"/></xsl:with-param>
   </xsl:call-template>
   </div>
  </xsl:if>
  <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-tnx-amt">Y</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <!--
  LI General Details Fieldset.
    
  Common General Details, Applicant Details, Beneficiary Details.
 -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <!-- <div id="generaldetails"> -->
     <!-- Common general details. -->
     <xsl:call-template name="common-general-details">
     <xsl:with-param name="show-template-id">N</xsl:with-param>
     </xsl:call-template>
	 <!-- Hidden fields -->
	  <xsl:if test="bo_lc_ref_id[.!='']">
	   <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bo_lc_ref_id</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">lc_ref_id</xsl:with-param>
       </xsl:call-template>
	  </xsl:if>
    <!--  <xsl:if test="lc_ref_id[.!='']">
      <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bene_type_code</xsl:with-param>
        <xsl:with-param name="id">bene_type_code_hidden</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">bene_type_other</xsl:with-param>
        <xsl:with-param name="id">bene_type_other_hidden</xsl:with-param>
       </xsl:call-template>
	 </xsl:if> -->
	 
	 <!-- Initiation From -->
     <xsl:if test="cross_references/cross_reference/type_code[.='02']">
      <xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
       <xsl:with-param name="id">parent_file_bo_ref_id_view</xsl:with-param>
       <xsl:with-param name="value" select="$parent_file/bo_ref_id" />
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
	 
	  <!-- BO_lc_ref_id -->
	  <!-- replaced by cross references?  
	  	<xsl:choose>
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
		</xsl:choose>
	-->
	<!-- 20170725_01 starts -->
	   <xsl:if test="$displaymode='view' and iss_date[.!=''] ">
	   		          <xsl:call-template name="row-wrapper">
			          <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
				          <xsl:with-param name="content"><div class="content">
				            <xsl:value-of select="iss_date"/>
				      </div></xsl:with-param>
		         </xsl:call-template>
	    
	    </xsl:if>
	<!-- 20170725_01 ends -->
	<!--  Expiry Date. --> 
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
      <xsl:with-param name="name">exp_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
     
     <!-- deal_ref_id -->

     <xsl:if test="not(cross_references)">
	  <xsl:call-template name="input-field">
      	<xsl:with-param name="label">XSL_GENERALDETAILS_RELATED_REF_ID</xsl:with-param>
      	<xsl:with-param name="name">deal_ref_id</xsl:with-param>
      	<xsl:with-param name="size">15</xsl:with-param>
        <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
	 </xsl:if>
     
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="show-entity">Y</xsl:with-param>
        <xsl:with-param name="prefix">applicant</xsl:with-param>
       </xsl:call-template>
        
       <!--
        If we have to, we show the reference field for applicants. This is
        specific to this form.
        -->
       <!-- <xsl:if test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
         <xsl:with-param name="name">applicant_reference</xsl:with-param>
         <xsl:with-param name="value">
         <xsl:variable name="ref"><xsl:value-of select="applicant_reference"/></xsl:variable>
         <xsl:value-of select="utils:decryptApplicantReference($ref)"/>
         </xsl:with-param>
         <xsl:with-param name="maxsize">34</xsl:with-param>
        </xsl:call-template>
       </xsl:if> -->
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
     <xsl:with-param name="legend"><xsl:value-of select="$beneficiaryHeader"/></xsl:with-param>
     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <!--  <xsl:with-param name="button-type">beneficiary</xsl:with-param> -->
     <xsl:with-param name="content">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_PARTIESDETAILS_TYPE_LABEL</xsl:with-param>
      <xsl:with-param name="name">bene_type_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="readonly"><xsl:if test="cross_references">Y</xsl:if></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
    	<xsl:when test="$displaymode='edit'">
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
       <xsl:with-param name="max-size"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_TRADE_LENGTH')"/></xsl:with-param>    
       <xsl:with-param name="button-content">
          <xsl:call-template name="get-button">
	        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
	        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
	        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
	      </xsl:call-template>
       </xsl:with-param>   
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </div>
   <!-- <div> -->
    <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
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
       <xsl:call-template name="main-bank-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="customer-reference-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
   <!-- </div> -->
   
   
   <!-- </div> -->
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
	        <xsl:with-param name="label">XSL_LABEL_DESCRIPTION_GOODS</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
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

<!-- Letter Of indemnity details -->  
   <xsl:template name="li-details">
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
  
  <!--
   Hidden fields for Letter of Indemnity
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
       <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">CREATE_OPTION</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
	  </xsl:call-template>
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
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template> 
</xsl:stylesheet>