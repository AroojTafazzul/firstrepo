<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 License (LS) Amendment Form, Customer Side.
 
 Note: Templates beginning with ls-amend- are in ls_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

author:    Shailly Palod
email:     shailly.palod@misys.com
##########################################################
-->
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="defaultresource">
  

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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LicenseScreen</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/common/amend_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
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
     <xsl:call-template name="build-inco-terms-data"/>
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
       
      <xsl:call-template name="hidden-fields"/>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details"/>
      <xsl:call-template name="ls-amend-amt-details"/>
      <xsl:call-template name="ls-amend-validity-details"/>
      <xsl:call-template name="ls-amend-shipment-details"/>
      <xsl:call-template name="amend-narrative"/>
      
      <!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
      
      <!-- Charges (hidden section) -->
      <xsl:for-each select="charges/charge">
       <xsl:call-template name="charge-details-hidden"/>
      </xsl:for-each>
      
      <!-- comments for return -->
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
    	<xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>    	
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
	   <xsl:with-param name="binding">misys.binding.trade.amend_ls</xsl:with-param>
	   <xsl:with-param name="override-help-access-key">LS_03</xsl:with-param>
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
	   <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
	   <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
	   <xsl:with-param name="value" select="issuing_bank/name"/>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">entity</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">swiftregexValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
		</xsl:call-template>
	  
	  <xsl:if test="$displaymode='edit'">
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
	   </xsl:call-template>
	  
	   <!-- Original Shipment Fields -->
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_origin_country</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/origin_country"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_supply_country</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/supply_country"/>
	   </xsl:call-template>
	 <!--   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_inco_term</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/inco_term"/>
	   </xsl:call-template> -->
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_inco_place</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/inco_place"/>
	   </xsl:call-template>
	   
	   <!-- Original Validity Fields -->
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_valid_from_date</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/valid_from_date"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_valid_for_nb</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/valid_for_nb"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_valid_for_period</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/valid_for_period"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_valid_to_date</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/valid_to_date"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">org_latest_payment_date</xsl:with-param>
	    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/latest_payment_date"/>
	   </xsl:call-template>
	  </xsl:if>
	  </div>
 </xsl:template>

 <!--
   LS General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="button-type">summary-details</xsl:with-param>
   <xsl:with-param name="content">
    <div id="generaldetails">
     <!-- Hidden fields. -->
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">ref_id</xsl:with-param>
	     </xsl:call-template>
	     <xsl:if test="$displaymode='edit'">
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">bo_ref_id</xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">org_iss_date</xsl:with-param>
	       <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/iss_date"/>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">ls_liab_amt</xsl:with-param>
	       <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/ls_liab_amt"/>
	      </xsl:call-template>
	     </xsl:if>
	     <!--  System ID. -->
	     <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
		     <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
		     <xsl:with-param name="value" select="ref_id" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	     
	     <xsl:if test="cust_ref_id[.!='']">
		     <xsl:call-template name="input-field">
			      <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
			      <xsl:with-param name="id">general_cust_ref_id_view</xsl:with-param>
			      <xsl:with-param name="value" select="cust_ref_id" />
			      <xsl:with-param name="override-displaymode">view</xsl:with-param>
		     </xsl:call-template>
	     </xsl:if>
	     
	     <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
		     <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
		     <xsl:with-param name="value" select="bo_ref_id" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	
	     <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
		     <xsl:with-param name="id">org_previous_iss_date_view</xsl:with-param>
		     <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/iss_date"/>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     </xsl:call-template>
	
		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_LICENSE_NUMBER</xsl:with-param>
		    <xsl:with-param name="id">ls_number_view</xsl:with-param>
		    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/ls_number" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_AUTH_REFERENCE</xsl:with-param>
		    <xsl:with-param name="id">auth_reference_view</xsl:with-param>
		    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/auth_reference" />
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_GENERALDETAILS_REG_DATE</xsl:with-param>
		    <xsl:with-param name="id">reg_date_view</xsl:with-param>
		    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/reg_date"/>
		    <xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="$displaymode='edit'">
			<xsl:call-template name="hidden-field">
			    <xsl:with-param name="name">reg_date</xsl:with-param>
			    <xsl:with-param name="value" select="org_previous_file/ls_tnx_record/reg_date"/>
			</xsl:call-template>
		</xsl:if>
	   
	      <!--  Amendment Date. --> 
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_DATE</xsl:with-param>
	     <xsl:with-param name="name">amd_date</xsl:with-param>
	     <xsl:with-param name="size">10</xsl:with-param>
	     <xsl:with-param name="maxsize">10</xsl:with-param>
	     <xsl:with-param name="type">date</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	     <xsl:with-param name="required">Y</xsl:with-param>
	     <xsl:with-param name="type">date</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">amd_no</xsl:with-param>
	    </xsl:call-template>
	    <xsl:if test="$displaymode='view'">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">amd_date</xsl:with-param>
	     </xsl:call-template>
	    </xsl:if>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template> 

  <!--
   Hidden fields for License 
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
       <xsl:with-param name="value">03</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fileActIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>