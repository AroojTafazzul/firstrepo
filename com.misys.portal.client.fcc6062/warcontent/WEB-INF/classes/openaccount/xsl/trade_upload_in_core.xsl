<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Letter of Credit (LC) Upload Form, Customer Side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">IN</xsl:param> 
  <xsl:param name="sub-product-code">ISO</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/InvoiceScreen</xsl:param>
  
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bk_upl_trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="in_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC UPLOAD TNX FORM TEMPLATE.
  -->
  <xsl:template match="in_tnx_record">
   <!-- Preloader  -->
   <script>
	dojo.ready(function(){
	
       	  	misys._config = (misys._config) || {};			
		misys._config.templatetype = misys._config.templatetype || 
	   {
	   <xsl:for-each select="upload_templates/upload_template[./product_code='IN']">
	     '<xsl:value-of select="upload_template_id" />':'<xsl:value-of select="default_template" />'
	     <xsl:if test="position()!=last()">,</xsl:if>
	   </xsl:for-each> 
	   };	
	});
</script>  
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
	     <xsl:with-param name="show-submit">N</xsl:with-param>
	     <xsl:with-param name="show-save">N</xsl:with-param>
	     <xsl:with-param name="show-upload">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <!-- Reauthentication -->	
			 	<xsl:call-template name="server-message">
			 		<xsl:with-param name="name">server_message</xsl:with-param>
			 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
			 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
				</xsl:call-template>
	  <xsl:call-template name="reauthentication" />
	  
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>
      <xsl:call-template name="seller-details" />
      
      <xsl:call-template name="bank-details" />
      <xsl:call-template name="template-details" />
      <!-- <xsl:call-template name="basic-amt-details"/> -->
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Form #1 : Attach Files -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
	    <xsl:call-template name="attachments-file-dojo">
	    	<xsl:with-param name="max-files">1</xsl:with-param>
	    </xsl:call-template>
	</xsl:if>

    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-submit">N</xsl:with-param>
     <xsl:with-param name="show-save">N</xsl:with-param>
     <xsl:with-param name="show-upload">Y</xsl:with-param>
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
    <xsl:with-param name="binding">misys.binding.openaccount.upload_in</xsl:with-param>
    <xsl:with-param name="override-help-access-key">IN_01_UPL</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:call-template name="common-hidden-fields"/>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
	<!--
		General Details Fieldset. 
		-->
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
 
   <xsl:variable name="show-cust-ref-id">N</xsl:variable>
   <xsl:variable name="show-bo-ref-id">Y</xsl:variable>
   <xsl:variable name="override-cust-ref-id-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:variable>
   <!-- Hidden fields. -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <!-- Don't display this in unsigned mode. -->
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">appl_date</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
   
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
    <xsl:apply-templates select="cross_references" mode="display_table_tnx"/>
   </xsl:if>
    
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label"><xsl:value-of select="$override-cust-ref-id-label"/></xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize">16</xsl:with-param>
	     <xsl:with-param name="required">Y</xsl:with-param>
	     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>

<!-- 				<xsl:call-template name="po-general-details" /> -->
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  
  
   <xsl:template name="seller-details">
   	<xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_IN_SELLER_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <!-- Common general details. -->
    <xsl:call-template name="party-details">
		<xsl:with-param name="show-entity">Y</xsl:with-param>
		<xsl:with-param name="show-BEI">Y</xsl:with-param>		
		<xsl:with-param name="prefix">seller</xsl:with-param>
		<xsl:with-param name="readonly">Y</xsl:with-param>
	</xsl:call-template>

	<!--
		If we have to, we show the reference field for applicants. This is
		specific to this form.
	-->
	<xsl:if
		test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
			<xsl:with-param name="name">buyer_reference</xsl:with-param>
			<xsl:with-param name="maxsize">64</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	
     <xsl:if test="$displaymode='edit'">
      <script>
      	dojo.ready(function(){
      		misys._config = misys._config || {};
			misys._config.customerReferences = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
	  </script>
     </xsl:if>
	
    </xsl:with-param>
    </xsl:call-template>
    </xsl:template>
    
    <!--  Bank Details Fieldset. -->
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
					<xsl:with-param name="sender-name">seller</xsl:with-param>
					<xsl:with-param name="sender-reference-name">seller_reference</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	 <!--  Template Details Fieldset. -->
	<xsl:template name="template-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INVOICE_TEMPLATE_DETAILS</xsl:with-param>
			<xsl:with-param name="content">

				<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_INVOICE_UPLOAD_TEMPLATE</xsl:with-param>
		     	<xsl:with-param name="name">upload_template_id</xsl:with-param>
	     		<xsl:with-param name="value">
	     		<xsl:choose>
	     			<xsl:when test="upload_id[.!='']"><xsl:value-of select="upload_id"/></xsl:when>
	     			<xsl:otherwise><xsl:value-of select="delimiter"/></xsl:otherwise>
	     		</xsl:choose>
		     	</xsl:with-param>
		     	<xsl:with-param name="options">
		     		<xsl:apply-templates select="upload_templates/upload_template[./product_code='IN' and ./invoice_type='ISO']"/>
		     	</xsl:with-param>
		     	<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="multichoice-field">
			    	<xsl:with-param name="label">ACTION_USER_SUBMIT</xsl:with-param>
			    	<xsl:with-param name="name">submit</xsl:with-param>
			    	<xsl:with-param name="type">checkbox</xsl:with-param>
			    	<xsl:with-param name="checked">
			    		<xsl:choose>
			    			<xsl:when test="submit[.='Y']">true</xsl:when>
			    			<xsl:otherwise>false</xsl:otherwise>
			    		</xsl:choose>
			    	</xsl:with-param>
				</xsl:call-template>
				
				<div id="overwrite_contact_radio_div">
				<xsl:call-template name="multichoice-field">
			    	<xsl:with-param name="label">XSL_TEMLATE_UPLOAD_OVERWRITE</xsl:with-param>
			    	<xsl:with-param name="name">import</xsl:with-param>
			    	<xsl:with-param name="id">radio_overwrite</xsl:with-param>
			    	<xsl:with-param name="type">radiobutton</xsl:with-param>
			    	<xsl:with-param name="value">overwrite</xsl:with-param>
			    	<xsl:with-param name="checked">
			    		<xsl:if test="import[.='overwrite']">Y</xsl:if>
			    	</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="multichoice-field">
			    	<xsl:with-param name="label">XSL_TEMLATE_UPLOAD_CONCAT</xsl:with-param>
			    	<xsl:with-param name="name">import</xsl:with-param>
			    	<xsl:with-param name="id">radio_concat</xsl:with-param>
			    	<xsl:with-param name="type">radiobutton</xsl:with-param>
			    	<xsl:with-param name="value">concat</xsl:with-param>
			    	<xsl:with-param name="checked">
			    		<xsl:if test="import[.='concat']">Y</xsl:if>
			    	</xsl:with-param>
				</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- PO Upload Template -->
	<xsl:template match="upload_template">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="upload_template_id"/></xsl:attribute>
			<xsl:value-of select="name"/>
		</option>
	</xsl:template>
  
  <!--
   Hidden fields for Letter of Credit 
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
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
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">UPLOAD</xsl:with-param>
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
	    <xsl:with-param name="name">productcode</xsl:with-param>
	     <xsl:with-param name="value">IN</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">subproductcode</xsl:with-param>
        <xsl:with-param name="value" select="$sub-product-code"/>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">templatetype</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
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