<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Secure Email (SE) Form, Bank Side.
 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      08/09/2011
author:    Ramesh M
email:     ramesh.mandala@misys.com
##########################################################
-->

<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization securitycheck utils defaultresource">
  
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
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
    <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param> 
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="clearImage"><xsl:value-of select="$images_path"/>pic_clear.gif</xsl:param> 

  <!-- Global Imports. -->
  
  <xsl:include href="common/bank_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
  
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
   
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="menu" >
      	<xsl:with-param name="show-template">N</xsl:with-param>
      </xsl:call-template>
      
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
			<xsl:call-template name="general-details" />
			<xsl:call-template name="se-instruction-details" />
     </xsl:with-param>
    </xsl:call-template>
     
    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
	   <xsl:with-param name="show-template">N</xsl:with-param>
	   <xsl:with-param name="second-menu">Y</xsl:with-param>
	</xsl:call-template>
   </div>
   
   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.bank.report_secure_email</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-help-access-key">
	   <xsl:choose>
	   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
	   	<xsl:when test="tnx_type_code[.='01']">SE_01</xsl:when>
	   	<xsl:otherwise>PR_01</xsl:otherwise>
	   </xsl:choose>
    </xsl:with-param> 
   </xsl:call-template>
  </xsl:template>
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields"/>
  <!--
   General Details Fieldset. 
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-general-details"/>
       <!-- Beneficiary Details -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="prefix">applicant</xsl:with-param>
        <xsl:with-param name="show-entity">Y</xsl:with-param>
        <xsl:with-param name="show-entity-button">Y</xsl:with-param>
        <xsl:with-param name="search-button-type">bank-applicant</xsl:with-param>
        <xsl:with-param name="entity-required">N</xsl:with-param>
        <xsl:with-param name="show-abbv">Y</xsl:with-param>
        <xsl:with-param name="disabled">N</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
        <xsl:with-param name="required-address">N</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
     
  </xsl:template>
  
   <xsl:template name="se-instruction-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SECURE_EMAIL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SE_PRIORITY</xsl:with-param>
      <xsl:with-param name="name">priority</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="priority"/></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <option value="1">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_HIGH')"/>
	      </option>
	      <option value="2">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_MEDIUM')"/>
	      </option>
	      <option value="3">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_LOW')"/>
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="priority[. = '' or . = '1']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_HIGH')"/></xsl:when>
          <xsl:when test="priority[. = '' or . = '2']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_MEDIUM')"/></xsl:when>
          <xsl:when test="priority[. = '' or . = '3']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_LOW')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     
    <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SECURE_EMAIL_TYPE</xsl:with-param>
      <xsl:with-param name="name">sub_product_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	  	<xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_se_advno_access',utils:getUserEntities($rundata))">
	        <option value="ADVNO">         
	      	<xsl:value-of select="localization:getDecode($language, 'N047', 'ADVNO')"/>
	     	</option>
	    </xsl:if>
	   	 <option value="OTHER">
	    	<xsl:value-of select="localization:getDecode($language, 'N047', 'OTHER')"/>
	   	 </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="sub_product_code[. = '' or . = 'ADVNO']"><xsl:value-of select="localization:getDecode($language, 'N047', 'ADVNO')"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N047', 'OTHER')"/></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
      
     <xsl:call-template name="input-field">
	  <xsl:with-param name="label">XSL_SE_TOPIC</xsl:with-param>
	  <xsl:with-param name="name">topic</xsl:with-param>
	  <xsl:with-param name="size">55</xsl:with-param>
	  <xsl:with-param name="maxsize">55</xsl:with-param>
	  <xsl:with-param name="fieldsize">large</xsl:with-param>
	  <xsl:with-param name="required">N</xsl:with-param>
	 </xsl:call-template>  
     
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SE_ADVICES_TYPE</xsl:with-param>
      <xsl:with-param name="name">se_type</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="se_type"/></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
          <option value="09">
	       <xsl:value-of select="localization:getDecode($language, 'N430', '09')"/>
	      </option>
	      <option value="10">
	       <xsl:value-of select="localization:getDecode($language, 'N430', '10')"/>
	      </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="se_type[. = '' or . = '09']"><xsl:value-of select="localization:getDecode($language, 'N430', '09')"/></xsl:when>
          <xsl:when test="se_type[. = '10']"><xsl:value-of select="localization:getDecode($language, 'N430', '10')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
   	<xsl:call-template name="input-field">
	  	<xsl:with-param name="label">XSL_SE_ACT_NO_LABEL</xsl:with-param>
	  	<xsl:with-param name="name">act_no</xsl:with-param>
	  	<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	  	<xsl:with-param name="readonly">Y</xsl:with-param>
	  	<xsl:with-param name="size">34</xsl:with-param>
	    <xsl:with-param name="maxsize">34</xsl:with-param>
 	</xsl:call-template>

    <xsl:if test="$displaymode='edit'">
   	 <xsl:call-template name="button-wrapper">		   	  
      <xsl:with-param name="show-image">Y</xsl:with-param>
	  <xsl:with-param name="show-border">N</xsl:with-param>
	  <xsl:with-param name="id">account_img</xsl:with-param>
	  <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
   	 </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$displaymode='edit'">
	    <xsl:call-template name="button-wrapper">
			<xsl:with-param name="id">clear_img</xsl:with-param>
			<xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
			<xsl:with-param name="show-image">Y</xsl:with-param>
			<xsl:with-param name="show-border">N</xsl:with-param>		
			<xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($clearImage)"/></xsl:with-param>	
		</xsl:call-template>
	</xsl:if>
	
	<xsl:if test="$displaymode='edit' or ( $displaymode='view' and bo_comment !='')">
		<xsl:call-template name="big-textarea-wrapper">
			<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:call-template name="textarea-field">
				<xsl:with-param name="name">bo_comment</xsl:with-param>
				<xsl:with-param name="rows">13</xsl:with-param>
				<xsl:with-param name="cols">75</xsl:with-param>
				<xsl:with-param name="maxlines">500</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
   
  	<xsl:template name="se_priority">
        <option value="1">
    	<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_HIGH')"/>
     	</option>
     	<option value="2">
    	<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_MEDIUM')"/>
     	</option>
     	<option value="3">
    	<xsl:value-of select="localization:getGTPString($language, 'XSL_SE_PRIORITY_LOW')"/>
     	</option>
  	</xsl:template>
  	<xsl:template name="sub_product_code_options">
  	<xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_se_advno_access',utils:getUserEntities($rundata))">
        <option value="ADVNO">         
      	<xsl:value-of select="localization:getDecode($language, 'N047', 'ADVNO')"/>
     	</option>
    </xsl:if> 	 
  	</xsl:template>
  	<xsl:template name="se_advices_type">
        <option value="09">
      	<xsl:value-of select="localization:getDecode($language, 'N430', '09')"/>
     	</option>
     	<option value="10">
      	<xsl:value-of select="localization:getDecode($language, 'N430', '10')"/>
     	</option>     	
  	</xsl:template>

  <xsl:template name="se-general-details">
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">ref_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">tnx_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">tnx_type_code</xsl:with-param>
    <xsl:with-param name="value">01</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">appl_date</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">current_date</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">prod_stat_code</xsl:with-param>
     <xsl:with-param name="value">03</xsl:with-param> 
    </xsl:call-template>
      
   <!-- Previous ctl date, used for synchronisation issues -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="bo_ctl_dttm" /></xsl:with-param>
   </xsl:call-template>
   <!-- Security Token -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <!-- Previous input date, used to know if the product has already been saved -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="bo_inp_dttm" /></xsl:with-param>
   </xsl:call-template>
   </div>

   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
    <xsl:call-template name="input-field">
	 <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	 <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	 <xsl:with-param name="maxsize">64</xsl:with-param>
	 <xsl:with-param name="required">N</xsl:with-param>
	</xsl:call-template>
	
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="id">appl_date_view</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
  	<xsl:call-template name="input-field">
	 <xsl:with-param name="label">XSL_SE_BANK_REF</xsl:with-param>
	 <xsl:with-param name="name">bo_ref_id</xsl:with-param>
	 <xsl:with-param name="maxsize">20</xsl:with-param>
	 <xsl:with-param name="required">Y</xsl:with-param>
	</xsl:call-template>
	
  </xsl:template>
  
   <!-- Free format message -->
  
  <xsl:template name="se-instructions-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SECURE_EMAIL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">free_format_text_row</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
        <xsl:with-param name="rows">16</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="button-type"></xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <!--
   Secure Email Realform.
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
       <xsl:with-param name="name">productcode</xsl:with-param>
       <xsl:with-param name="value">SE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>