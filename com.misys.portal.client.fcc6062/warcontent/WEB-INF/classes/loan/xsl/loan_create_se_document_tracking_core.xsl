<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for 

 Loan - Document Tracking Form, Customer Side.
 
 Resembles to Customer side Secure Email(SE) form. 
 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      17/02/15
author:    Saïd SAI
email:     said.sai0@misys.com
##########################################################
-->


<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  exclude-result-prefixes="localization utils">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="option"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/DocumentTrackingScreen</xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
  <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />     
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>
  
  
  <!-- 
   SE TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="se_tnx_record"> 
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>
   
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		<!-- Form #0 : Main Form -->
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
			
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="server-message">
					<xsl:with-param name="name">server_message</xsl:with-param>
					<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
					<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
				</xsl:call-template>
				     
				<xsl:apply-templates select="cross_references" mode="hidden_form"/>
				<xsl:call-template name="hidden-fields"/>
				<xsl:call-template name="general-details" />
				<xsl:call-template name="borrower-details" />
				<xsl:call-template name="free-format-message" />
				
				<!-- comments for return -->
				<xsl:call-template name="comments-for-return">
					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
					<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
				</xsl:call-template>
				   
			 </xsl:with-param>
		</xsl:call-template>      
		<xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
		<xsl:call-template name="attachments-file-dojo">
		<xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
		  	 	</xsl:call-template>
		   </xsl:if>
		
		<!-- The form that is submitted -->
		<xsl:call-template name="realform" />
		
		<!-- Reauthentication -->
		<xsl:call-template name="reauthentication" />
		 
		
		
		<!-- Display common menu, this time outside the form 
		(buttons diplayed at the bottom of the Page-form)-->
		<xsl:call-template name="menu">
		<xsl:with-param name="second-menu">Y</xsl:with-param>
		<xsl:with-param name="show-template">N</xsl:with-param>
		<xsl:with-param name="show-return">Y</xsl:with-param>
		 </xsl:call-template>
	</div>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
   
  </xsl:template>


 
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
	<xsl:with-param name="binding">misys.binding.loan.create_se_dt</xsl:with-param>
	<xsl:with-param name="override-action"><xsl:value-of select="$realform-action"/></xsl:with-param>
    <xsl:with-param name="override-help-access-key"><xsl:value-of select="product_code"/>_<xsl:value-of select="sub_product_code"/>_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">brch_code</xsl:with-param>
     <xsl:with-param name="value" select="brch_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
     <xsl:with-param name="value" select="company_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_name</xsl:with-param>
     <xsl:with-param name="value" select="company_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_id</xsl:with-param>
     <xsl:with-param name="value" select="tnx_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
     <xsl:with-param name="value" select="//ctl_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
     <xsl:with-param name="value" select="inp_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">prod_stat_code</xsl:with-param>
     <xsl:with-param name="value" select="prod_stat_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">date_time</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">applicant_reference</xsl:with-param>
	</xsl:call-template> 
   </div>
  </xsl:template>
 
  <!--
   General Details Fieldset. 
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-dt-general-details"/> 
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Free format message -->
  <xsl:template name="free-format-message">
	<xsl:choose>
	    <xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
	  	   <!-- Don't show the file details for the draft view mode, but do in all other cases -->
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:call-template name="fieldset-wrapper">
		    <xsl:with-param name="legend">XSL_HEADER_DOCUMENT_TRACKING_COMMENTS</xsl:with-param>
		    <xsl:with-param name="content">
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">free_format_text_row</xsl:with-param>
				<xsl:with-param name="type">textarea</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="textarea-field">
						<xsl:with-param name="name">free_format_text</xsl:with-param>
						<xsl:with-param name="rows">16</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param> 
						<xsl:with-param name="button-type">phrase</xsl:with-param>
					</xsl:call-template>
			 </xsl:with-param>
			</xsl:call-template>
		    </xsl:with-param>
		</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name="se-dt-general-details">
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">doc_track_id</xsl:with-param>
    </xsl:call-template>

    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </div>
   
   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>

   <!--  Document Tracking ID -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_DOC_TRACK_ID</xsl:with-param>
    <xsl:with-param name="id">doc_track_id</xsl:with-param>
    <xsl:with-param name="value" select="doc_track_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="id">appl_date_view</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>

    
   <xsl:call-template name="entity-details" />

	</xsl:template>

	<!-- Entity Details -->
	<xsl:template name="entity-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ENTITY_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
					<script>
						dojo.ready(function(){
							misys._config = misys._config || {};
							misys._config.customerReferences = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
						});
					</script>
					<xsl:call-template name="address">
			        <xsl:with-param name="show-entity">Y</xsl:with-param>
					<xsl:with-param name="prefix">applicant</xsl:with-param>
					</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<xsl:template name="borrower-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
	    		<xsl:with-param name="name">issuing_bank_abbv_name_view</xsl:with-param>
	     		<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
    		</xsl:call-template>
   			<xsl:call-template name="input-field">
	    		<xsl:with-param name="name">applicant_reference_view</xsl:with-param>
	     		<xsl:with-param name="label">XSL_LOAN_BORROWER_REFERENCE</xsl:with-param>
	     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/></xsl:with-param>
    		</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
  <!--
   File upload Realform.
   -->
  <xsl:template name="realform">  
   <xsl:call-template name="form-wrapper">
   <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="name">realform</xsl:with-param>
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
       <xsl:with-param name="value">DT</xsl:with-param>
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
       <xsl:with-param name="name">fileHashCode</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">validation_type</xsl:with-param>
       <xsl:with-param name="value">MD5</xsl:with-param>
      </xsl:call-template>
      
 	<xsl:call-template name="reauth_params"/>   

     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
</xsl:stylesheet>