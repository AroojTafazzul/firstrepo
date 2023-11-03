<?xml version="1.0" encoding="UTF-8"?>

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
  <xsl:param name="option"/>
  <xsl:param name="tnxType"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/SecureEmailScreen</xsl:param>

  <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  
  
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
      	<xsl:with-param name="saveButtonId">N</xsl:with-param>
	   	<xsl:with-param name="show-submit">Y</xsl:with-param>
	   	<xsl:with-param name="show-save">N</xsl:with-param>
	   	<xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:if test="$displaymode='edit'">
         <xsl:call-template name="general-details" />
      </xsl:if>
<!-- 	    <xsl:call-template name="general-details" /> -->
	    <xsl:call-template name="upload-bank-details" />  
<!-- 	    <xsl:call-template name="free-format-message" /> -->
     </xsl:with-param>
    </xsl:call-template>
      
    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>
    
    <xsl:if test="$displaymode = 'edit'">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
	   <xsl:with-param name="saveButtonId">N</xsl:with-param>
	   <xsl:with-param name="show-submit">Y</xsl:with-param>
	   <xsl:with-param name="show-save">N</xsl:with-param>
       <xsl:with-param name="second-menu">Y</xsl:with-param>
       <xsl:with-param name="show-template">N</xsl:with-param>
    </xsl:call-template>
   </div>
   
      <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
   

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
 
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.correspondence_secure_email</xsl:with-param>
    <xsl:with-param name="override-help-access-key">CH_01</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
    <xsl:template name="upload-bank-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
    <xsl:with-param name="content">

      <xsl:call-template name="se-upload-bank-details"/>
    </xsl:with-param>
   </xsl:call-template>
    <xsl:if test="$displaymode='edit'">
  		 <xsl:call-template name="free-format-message" />
   </xsl:if>
  </xsl:template>
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
    <xsl:call-template name="localization-dialog"/>
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
    <xsl:with-param name="name">sub_product_code</xsl:with-param>
    <xsl:with-param name="value">SEEML</xsl:with-param>
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
      <xsl:call-template name="se-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="se-general-details">
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </div>
   
   <!--  System ID. -->
   <xsl:if test="$displaymode='edit'">
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
	    <xsl:with-param name="value" select="ref_id" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>
   
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="$displaymode='view'">
	   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_SECURE_EMIAIL_REQUEST_TYPE</xsl:with-param>
	    <xsl:with-param name="value" select="topic_description" />
	    <xsl:with-param name="override-displaymode">view</xsl:with-param>
	   </xsl:call-template>
   </xsl:if>

   <!-- Entity -->
   <xsl:if test="entities[number(.) &gt; 0]">
	<xsl:call-template name="entity-field">
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="button-type">entity</xsl:with-param>
     <xsl:with-param name="prefix">applicant</xsl:with-param>
    </xsl:call-template>	
   </xsl:if>	   
	<xsl:call-template name="select-field">
      	<xsl:with-param name="label">XSL_SE_TOPIC</xsl:with-param>
      	<xsl:with-param name="name">topic</xsl:with-param>
      	<xsl:with-param name="required">Y</xsl:with-param>
      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
      	<xsl:with-param name="options">			       		
			<xsl:choose>
				<xsl:when test="$displaymode='edit'">
				<xsl:for-each select="contact_helpdesk/contact_helpdesk">
				    <option>
				    <xsl:attribute name="value"><xsl:value-of select="topic_id"></xsl:value-of></xsl:attribute>
				    <xsl:value-of select="topic_description"/></option>
				</xsl:for-each>
			   </xsl:when>
			</xsl:choose>
     	</xsl:with-param>
   	</xsl:call-template>
  </xsl:template>
  
  <!-- Free format message -->

  <xsl:template name="free-format-message">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text_row</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
       	<xsl:with-param name="label">XSL_HEADER_CORRESPONDENCE_DETAILS</xsl:with-param>
       	<xsl:with-param name="show-label">N</xsl:with-param>
        <xsl:with-param name="name">free_format_text</xsl:with-param>
        <xsl:with-param name="rows">16</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="button-type">phrase</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  	<xsl:template name="se-upload-bank-details">        
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
     	<xsl:if test="$displaymode='edit'">
       		   <xsl:call-template name="hidden-field">
			       	<xsl:with-param name="name">issuing_bank_customer_reference_temp</xsl:with-param>
			       	<xsl:with-param name="value"><xsl:value-of select="issuing_bank/reference"/></xsl:with-param>
		       </xsl:call-template>
       	</xsl:if>
     </xsl:template>
  
  <!--
   SE Contact Helpdesk real form.
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
       <xsl:with-param name="value" select="$tnxType" ></xsl:with-param>
      </xsl:call-template>
   	  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SEEML</xsl:with-param>
	  </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>